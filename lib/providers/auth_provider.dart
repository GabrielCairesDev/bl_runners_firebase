// https://firebase.flutter.dev/

import 'dart:io';

import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/pages/pagina_concluir_cadastro/controller/pagina_concluir_controlador.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/pagina_registrar_usuario/controller/pagina_registrar_controlador.dart';
import 'package:bl_runners_firebase/providers/data_provider.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
/*
===================================================
====================== MÉTODOS ====================
===================================================
*/

// Método para registrar conta
  Future<void> registrar(BuildContext context, {required String email, required String senha, required String nome}) async {
    // Controlador Pagina Registrar
    final controladorPaginaRegistrar = Provider.of<PaginaRegistrarControlador>(context, listen: false);
    // Controlador DataBase Firebase
    final controladorDataProvider = Provider.of<DataProvider>(context, listen: false);

    // Tratamento de erros
    try {
      // Fazer registro
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha);

      // Registrar nome no Auth
      await credential.user!.updateDisplayName(nome);

      // Enviar e-mail de verificação
      await credential.user!.sendEmailVerification();

      // Salvar Data
      if (context.mounted) {
        controladorDataProvider.registrarUsuarioData(
          context,
          id: credential.user!.uid,
          email: credential.user!.email.toString(),
          nome: nome,
        );
      }

      //  Mensagem conta criada
      if (context.mounted) _mensagemContaCriada(context);

      // Atualizar estado carregando
      controladorPaginaRegistrar.atualizarCarregando();

      // Resetar valores
      controladorPaginaRegistrar.resetarValores();

      // Erros
    } on FirebaseAuthException catch (e) {
      // Atualizar estado carregando
      controladorPaginaRegistrar.atualizarCarregando();
      // Senha fraca
      if (e.code == 'weak-password') {
        if (context.mounted) Mensagens.snackBar(context, 'A senha é muito fraca.');

        // E-mail em uso
      } else if (e.code == 'email-already-in-use') {
        if (context.mounted) Mensagens.snackBar(context, 'Este e-mail já está em uso.');

        // Outro erro
      } else {
        if (context.mounted) Mensagens.snackBar(context, 'Erro durante o registro: ${e.message}');
      }
    } catch (e) {
      if (context.mounted) Mensagens.snackBar(context, 'Erro desconhecido: $e');
      // Atualizar estado carregando
      controladorPaginaRegistrar.atualizarCarregando();
    }
  }

  // Método para fazer login
  Future<void> entrar(BuildContext context, {required String email, required String senha, required bool entradaAutomatica}) async {
    // Controlador Pagina Entrar
    final controladorPaginaEntrar = Provider.of<PaginaEntrarControlador>(context, listen: false);

    // Pegar (entrada automática)
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Tratamento de erros
    try {
      // Fazer o login
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha);

      // Verificar se o usuário não é NULL
      if (credential.user != null) {
        // Verficiar se o e-mail foi ativado
        if (credential.user!.emailVerified == true) {
          // Salvar (Entrada automática)
          await prefs.setBool("entradaAutomatica", entradaAutomatica);

          // Entrar no APP
          if (context.mounted) context.pushReplacement(Rotas.navegar);
        } else {
          // Quando o e-mail não é verificado
          if (context.mounted) _emailNaoVerificado(context, credential);
        }
        // Atualizar carregando
        controladorPaginaEntrar.atualizarCarregando();

        // Resetar os valores
        controladorPaginaEntrar.resetarValores();
      }

      // Erros
    } on FirebaseAuthException catch (e) {
      // Usuário não encontrado
      if (e.code == 'user-not-found') {
        if (context.mounted) Mensagens.snackBar(context, 'E-mail não registrado!');

        // Senha inválida
      } else if (e.code == 'wrong-password') {
        if (context.mounted) Mensagens.snackBar(context, 'Senha inválida!');

        // E-mail inválido
      } else if (e.code == 'invalid-email') {
        if (context.mounted) Mensagens.snackBar(context, 'E-mail inválido!');

        // Outro erro
      } else {
        if (context.mounted) Mensagens.snackBar(context, 'Erro ao fazer login!');
      }

      // Atualizar o estado do carregando
      controladorPaginaEntrar.atualizarCarregando();
    } catch (e) {
      // Mensagem de erro
      if (context.mounted) Mensagens.snackBar(context, 'Erro ao fazer login! $e');
      controladorPaginaEntrar.atualizarCarregando();
    }
  }

  // Metodo autoEntrar
  Future<void> autoEntrar(BuildContext context) async {
    // Usuário atual
    final user = FirebaseAuth.instance.currentUser;

    // SharedPreferences (Entrada automática)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool entradaAutomatica = prefs.getBool('entradaAutomatica') ?? false;

    // Verificar se o usuário é null
    if (user != null) {
      // Recarregar usuário
      user.reload();
      try {
        // Verificar a entrada automática e o e-mail verificado
        if (entradaAutomatica == true && user.emailVerified == true) {
          // Enviar para a pagina Navegar
          if (context.mounted) context.pushReplacement(Rotas.navegar);
        } else {
          if (context.mounted) sair(context);
        }
      } catch (e) {
        if (context.mounted) sair(context);
      }
    } else {
      if (context.mounted) sair(context);
    }
  }

  // Método concluir Cadastro
  Future<void> concluirCadastro(BuildContext context, imagemArquivo) async {
    User? usuario = FirebaseAuth.instance.currentUser;
    final concluirControlador = Provider.of<PaginaConcluirControlador>(context, listen: false);

    if (usuario != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("perfil_fotos/${usuario.uid}");
      UploadTask uploadTask = ref.putFile(File(imagemArquivo!.path));

      uploadTask.snapshotEvents.listen(
        (TaskSnapshot taskSnapshot) async {
          switch (taskSnapshot.state) {
            case TaskState.running:
              break;
            case TaskState.paused:
              concluirControlador.alterarCarregando();
              break;
            case TaskState.canceled:
              concluirControlador.alterarCarregando();
              break;
            case TaskState.error:
              Mensagens.snackBar(context, 'Algo deu errado');
              concluirControlador.alterarCarregando();
              break;
            case TaskState.success:
              var downloadUrl = await ref.getDownloadURL();
              usuario.updatePhotoURL(downloadUrl);

              final modeloDeUsuario = ModeloDeUsuario(
                id: usuario.uid,
                nome: concluirControlador.controladorNome.text,
                email: usuario.email.toString(),
                fotoUrl: downloadUrl,
                genero: concluirControlador.controladorGenero.toString(),
                master: false,
                admin: false,
                autorizado: false,
                cadastroConcluido: true,
                dataNascimento: concluirControlador.nascimentoData as DateTime,
              );
              await FirebaseFirestore.instance.collection('usuariosPerfil').doc(usuario.uid).set(modeloDeUsuario.toJson(), SetOptions(merge: true));
              if (context.mounted) context.pushReplacement(Rotas.navegar);
              concluirControlador.alterarCarregando();
              break;
          }
        },
      );
    } else {
      Mensagens.snackBar(context, 'Algo deu errado');
      concluirControlador.alterarCarregando();
    }
  }

// Método para sair
  Future<void> sair(BuildContext context) async {
    // Pegar SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Navegar para a pagina entrar
    if (context.mounted) context.pushReplacement(Rotas.entrar);
    // Tornar falso (entradaAutomatica)
    await prefs.setBool("entradaAutomatica", false);
    // deslogar
    await FirebaseAuth.instance.signOut();
  }

/*
===================================================
====================== OUTROS =====================
===================================================
*/

  // Mostrar Caixa de dialogo e enviar email
  Future<void> _emailNaoVerificado(BuildContext context, UserCredential credential) async {
    // Exibir caixa de diálogo
    if (credential.user != null) {
      Mensagens.caixaDeDialogo(
        context,
        titulo: 'Atenção!',
        texto: 'Por favor, verifique o seu e-mail.\n ${credential.user!.email}',
        textoBotao: 'ok',
        onPressed: () {
          context.pop();
        },
      );
      // Enviar e-mail de recuperação
      await credential.user!.sendEmailVerification();
      // Executar método sair
      //await sair(context);
    } else {
      Mensagens.snackBar(context, 'Algo deu errado');
    }
  }

  // Mensagem conta registrada
  Future<void> _mensagemContaCriada(BuildContext context) async {
    Mensagens.caixaDeDialogo(
      context,
      titulo: "Parabéns!",
      texto: 'Sua conta foi criada com sucesso. Verifique o seu e-mail!',
      textoBotao: 'OK',
      onPressed: () async {
        context.pop();
        //   await sair(context);
      },
    );
  }
}
