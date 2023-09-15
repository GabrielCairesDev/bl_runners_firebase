// https://firebase.flutter.dev/

import 'dart:io';

import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_salvar_perfil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/pages/06_pagina_concluir_cadastro/controller/pagina_concluir_controlador.dart';
import 'package:bl_runners_firebase/pages/05_pagina_editar_perfil/controller/pagina_editar_perfil_controlador.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/01_pagina_registrar_usuario/controller/pagina_registrar_controlador.dart';
import 'package:bl_runners_firebase/providers/data_provider.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
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
    final controladorDataProvider = Provider.of<FireBaseFireStoreSalvarPerfil>(context, listen: false);

    // Tratamento de erros
    try {
      // Fazer registro
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha);

      // Registrar nome no Auth
      credential.user!.updateDisplayName(nome);

      // Enviar e-mail de verificação
      await credential.user!.sendEmailVerification();

      // Salvar Data
      if (context.mounted) {
        controladorDataProvider.salvarPerfil(
          context,
          id: credential.user!.uid,
          email: credential.user!.email.toString(),
          nome: nome,
        );
      }

      //  Mensagem conta criada
      if (context.mounted) _mensagemSucesso(context, texto: 'Conta criada com sucesso!\nVerifique o seu e-mail.');

      // Fechar pagina
      // if (context.mounted) sair(context);

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
        if (context.mounted) _mensagemErro(context, texto: 'A senha é muito fraca.');
        // Atualizar estado carregando
        controladorPaginaRegistrar.atualizarCarregando();

        // E-mail em uso
      } else if (e.code == 'email-already-in-use') {
        if (context.mounted) _mensagemErro(context, texto: 'Este e-mail já está em uso.');
        // Atualizar estado carregando
        controladorPaginaRegistrar.atualizarCarregando();

        // Outro erro
      } else {
        if (context.mounted) _mensagemErro(context, texto: 'Erro durante o registro: ${e.message}');
        // Atualizar estado carregando
        controladorPaginaRegistrar.atualizarCarregando();
      }
    } catch (e) {
      if (context.mounted) _mensagemErro(context, texto: 'Erro desconhecido: $e');
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
          if (context.mounted) _mensagemInfo(context, texto: 'E-mail de verificação enviado para:\n${credential.user!.email}');
          await credential.user!.sendEmailVerification();
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
        if (context.mounted) _mensagemErro(context, texto: 'E-mail não registrado!');

        // Senha inválida
      } else if (e.code == 'wrong-password') {
        if (context.mounted) _mensagemErro(context, texto: 'Senha inválida!');

        // E-mail inválido
      } else if (e.code == 'invalid-email') {
        if (context.mounted) _mensagemErro(context, texto: 'E-mail inválido!');

        // Outro erro
      } else {
        if (context.mounted) _mensagemErro(context, texto: 'Erro ao fazer login!');
      }

      // Atualizar o estado do carregando
      controladorPaginaEntrar.atualizarCarregando();
    } catch (e) {
      // Mensagem de erro
      if (context.mounted) _mensagemErro(context, texto: 'Erro ao fazer login! $e');
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

  // Método excluirconta
  Future<void> excluirConta(BuildContext context, {required String senha}) async {
    // Pegar controlador da pagina
    final controladorPaginaEditarPerfil = Provider.of<PaginaEditarPerfilControlador>(context, listen: false);
    // Pegar usuário
    final user = FirebaseAuth.instance.currentUser;
    // Verificar se é nulo
    if (user != null) {
      // Tratamento de erros
      try {
        // Excluir a conta
        final AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: senha);
        // Autentica outra vez para ter certeza
        await user.reauthenticateWithCredential(credential);

        // Deletar usuário
        await user.delete().then(
          (value) {
            // Conta excluida
            if (context.mounted) {
              // Mensagem perfil excluído
              _mensagemSucesso(context, texto: 'O seu perfil foi excluído!');
              // Mandar para a pagina inicial
              context.pushReplacement(Rotas.entrar);
              // Estado do carregando
              controladorPaginaEditarPerfil.alterarCarregando();
              // Limpar campos
              controladorPaginaEditarPerfil.controladorSenha.clear();
            }
            // Apagar data
            FirebaseFirestore.instance.collection('usuarios').doc(user.uid).collection('perfil').doc('dados').delete();
            // Apagar foto
            FirebaseStorage.instance.ref().child("perfil_fotos/${user.uid}").delete();
          },
        );

        // Erros
      } on FirebaseAuthException catch (e) {
        // Se o erro for de senha inválida
        if (e.code == 'wrong-password') {
          // Fechar
          if (context.mounted) Navigator.of(context).pop();
          // Mensagem
          if (context.mounted) _mensagemErro(context, texto: 'Senha inválida!');
          // Estado carregando
          controladorPaginaEditarPerfil.alterarCarregando();
          // Limpar campos
          controladorPaginaEditarPerfil.controladorSenha.clear();
        } else {
          // Fechar
          if (context.mounted) Navigator.of(context).pop();
          // Erro inesperado
          if (context.mounted) _mensagemErro(context, texto: 'Erro ao excluir conta!');
          // Estado carregando
          controladorPaginaEditarPerfil.alterarCarregando();
          // Limpar campos
          controladorPaginaEditarPerfil.controladorSenha.clear();
        }
      } catch (e) {
        // Fechar
        if (context.mounted) Navigator.of(context).pop();
        // Erro inesperado
        if (context.mounted) _mensagemErro(context, texto: 'Erro ao excluir conta!');
        // Estado carregando
        controladorPaginaEditarPerfil.alterarCarregando();
        // Limpar campos
        controladorPaginaEditarPerfil.controladorSenha.clear();
      }
    }
  }

  // Método recuperar conta
  Future<void> recuprarConta(BuildContext context, {required String email}) async {
    final controladorPaginaEntrar = Provider.of<PaginaEntrarControlador>(context, listen: false);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) _mensagemSucesso(context, texto: 'E-mail de recuperação enviado para:\n$email');
      controladorPaginaEntrar.atualizarCarregando();
      controladorPaginaEntrar.controladorEmailRecuperar.clear();
    } catch (e) {
      if (context.mounted) _mensagemErro(context, texto: 'Erro ao enviar e-mail de recuperação:\n$e');
      controladorPaginaEntrar.atualizarCarregando();
    }
  }

  // Método editar conta
  Future<void> editarDados(BuildContext context, {required File? imagemArquivo, required String nome, required String genero, DateTime? data}) async {
    final controladorPaginaEditarPerfil = Provider.of<PaginaEditarPerfilControlador>(context, listen: false);

    // Usuário atual
    final user = FirebaseAuth.instance.currentUser;

    // Verificar se o usuário é nulo
    if (user != null) {
      if (imagemArquivo != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("perfil_fotos/${FirebaseAuth.instance.currentUser?.uid}");
        UploadTask uploadTask = ref.putFile(File(imagemArquivo.path));
        uploadTask.snapshotEvents.listen(
          (TaskSnapshot taskSnapshot) async {
            switch (taskSnapshot.state) {
              case TaskState.running:
                break;
              case TaskState.paused:
                controladorPaginaEditarPerfil.alterarCarregando();
                break;
              case TaskState.canceled:
                controladorPaginaEditarPerfil.alterarCarregando();
                break;
              case TaskState.error:
                _mensagemErro(context, texto: 'Algo deu errado');
                controladorPaginaEditarPerfil.alterarCarregando();
                break;
              case TaskState.success:
                var downloadUrl = await ref.getDownloadURL();
                user.updatePhotoURL(downloadUrl); // ATUALIZANDO NA RAIZ
            }
          },
        );
      }
      await user.updateDisplayName(nome); // ATUALIZANDO NA RAIZ

      final modeloDeUsuario = ModeloDeUsuario(
        // MANTER ORIGINAL
        id: user.uid, // PEGAR DA RAIZ
        email: user.email.toString(), // PEGAR DA RAIZ
        master: false, // controladorUsuario.usuarioModelo!.master
        admin: false, // controladorUsuario.usuarioModelo!.admin
        autorizado: false, // controladorUsuario.usuarioModelo!.admin
        cadastroConcluido: true,
        //ATUALIZAR
        nome: user.displayName.toString(), // PEGAR DA RAIZ
        genero: genero,
        dataNascimento: data as DateTime,
        fotoUrl: user.photoURL.toString(), // PEGAR DA RAIZ
      );

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid.toString())
          .collection('perfil')
          .doc('dados')
          .set(modeloDeUsuario.toJson(), SetOptions(merge: true));

      if (context.mounted) {
        context.pop();
        controladorPaginaEditarPerfil.alterarCarregando();
        _mensagemSucesso(context, texto: 'Perfil editado com sucesso!');
      }
    } else {
      _mensagemErro(context, texto: 'Algo deu errado');
      controladorPaginaEditarPerfil.alterarCarregando();
    }
  }

/*
===================================================
====================== OUTROS =====================
===================================================
*/

  // Mensagem sucesso
  Future<void> _mensagemSucesso(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: texto,
      ),
    );
  }

  // Mensagem erro
  Future<void> _mensagemErro(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: texto,
      ),
    );
  }

  // Mensagem Info
  Future<void> _mensagemInfo(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        backgroundColor: Colors.orange,
        message: texto,
      ),
    );
  }
}
