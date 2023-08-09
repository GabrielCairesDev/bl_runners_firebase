import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/modelo_de_usuario.dart';
import '../../../routes/rotas.dart';
import '../../../widgets/mensagens.dart';

class PaginaEntrarControlador extends ChangeNotifier {
  final controladorEmail = TextEditingController(text: 'gabriel.araujo.caires@gmail.com');
  final controladorSenha = TextEditingController(text: 'gabriel');

  GlobalKey<FormState> globalKeyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeySenha = GlobalKey<FormState>();

  bool esconderSenha = true;
  bool entradaAutomatica = false;
  bool carregando = false;

  String? validadorEmail(String? value) {
    final regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value!.isEmpty) {
      return 'Campo obrigatório!';
    } else if (!regExp.hasMatch(value)) {
      return 'E-mail invalido!';
    }
    return null;
  }

  String? validadorSenha(String? value) {
    if (value!.isEmpty) {
      return 'Campo obrigatório!';
    }
    return null;
  }

  validarCampos(context) {
    if (globalKeyEmail.currentState!.validate() && globalKeySenha.currentState!.validate() && carregando == false) {
      atualizarCarregando();
      entrar(context);
    }
  }

  Future entrar(BuildContext context) async {
    try {
      final usuario = await FirebaseAuth.instance.signInWithEmailAndPassword(email: controladorEmail.text, password: controladorSenha.text);
      // final usuario = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: controladorEmail.text, password: controladorSenha.text)).user;
      // final modeloDeUsuario = ModeloDeUsuario.fromMap((await FirebaseFirestore.instance.collection('usuarios').doc(usuario!.uid).get()).data() as Map<String, dynamic>);

      if (usuario.user!.emailVerified == true) {
        final usarioDados = await FirebaseFirestore.instance.collection('usuarios').doc(usuario.user!.uid).get();
        salvarEntradaAutomatica();

        if (usarioDados.exists) {
          final modeloDeUsuario = ModeloDeUsuario.fromMap(usarioDados.data() as Map<String, dynamic>);
          if (modeloDeUsuario.cadastroConcluido == false || modeloDeUsuario.cadastroConcluido == null) {
            if (context.mounted) context.pushReplacement(Rotas.navegar);
          } else {
            if (context.mounted) context.pushReplacement(Rotas.concluir);
          }
        } else {
          final modeloDeUsuario = ModeloDeUsuario();
          await FirebaseFirestore.instance.collection('usuarios').doc(usuario.user!.uid).set(modeloDeUsuario.toMap());
          if (context.mounted) entrar(context);
        }
      } else {
        if (context.mounted) mensagemConfirmarEmail(context, usuario.user!.email as User);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Mensagens.snackBar(context, 'E-mail não registrado!');
      } else if (e.code == 'wrong-password') {
        Mensagens.snackBar(context, 'Senha inválida!');
      } else if (e.code == 'invalid-email') {
        Mensagens.snackBar(context, 'E-mail inválido!');
      } else {
        Mensagens.snackBar(context, 'Erro ao fazer login!');
      }
    } catch (e) {
      Mensagens.snackBar(context, 'Erro ao fazer login! $e');
    }
    atualizarCarregando();
  }

  mensagemConfirmarEmail(context, User usuario) async {
    Mensagens.caixaDeDialogo(
      context,
      titulo: 'Atenção!',
      texto: 'Por favor, verifique o seu e-mail.\n ${usuario.email}',
      textoBotao: 'ok',
      onPressed: () => Navigator.of(context).pop(),
    );
    await usuario.sendEmailVerification();
    await FirebaseAuth.instance.signOut();
  }

  resetarValores() {
    controladorEmail.clear();
    controladorSenha.clear();
    esconderSenha = true;
    entradaAutomatica = false;
  }

  atualizarCarregando() {
    carregando = !carregando;
    notifyListeners();
  }

  emailNaoVerificado() {}

  Future<void> salvarEntradaAutomatica() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("entradaAutomatica", entradaAutomatica);
    resetarValores();
  }
}
