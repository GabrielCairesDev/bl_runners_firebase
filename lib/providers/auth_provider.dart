import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:bl_runners_firebase/pages/05_pagina_editar_perfil/controller/pagina_editar_perfil_controlador.dart';
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
              controladorPaginaEditarPerfil.alterarEstadoCarregando();
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
          controladorPaginaEditarPerfil.alterarEstadoCarregando();
          // Limpar campos
          controladorPaginaEditarPerfil.controladorSenha.clear();
        } else {
          // Fechar
          if (context.mounted) Navigator.of(context).pop();
          // Erro inesperado
          if (context.mounted) _mensagemErro(context, texto: 'Erro ao excluir conta!');
          // Estado carregando
          controladorPaginaEditarPerfil.alterarEstadoCarregando();
          // Limpar campos
          controladorPaginaEditarPerfil.controladorSenha.clear();
        }
      } catch (e) {
        // Fechar
        if (context.mounted) Navigator.of(context).pop();
        // Erro inesperado
        if (context.mounted) _mensagemErro(context, texto: 'Erro ao excluir conta!');
        // Estado carregando
        controladorPaginaEditarPerfil.alterarEstadoCarregando();
        // Limpar campos
        controladorPaginaEditarPerfil.controladorSenha.clear();
      }
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
