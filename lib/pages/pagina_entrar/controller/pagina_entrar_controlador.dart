import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      if (usuario.user != null && usuario.user!.emailVerified) {
        if (context.mounted) context.pushReplacement(Rotas.navegar);
        salvarEntradaAutomatica();
      } else {
        await usuario.user?.sendEmailVerification();
        if (context.mounted) {
          Mensagens.caixaDeDialogo(
            context,
            titulo: 'Atenção!',
            texto: 'Por favor, verifique o seu e-mail.\n ${usuario.user!.email}',
            textoBotao: 'ok',
            onPressed: () => Navigator.of(context).pop(),
          );
          await FirebaseAuth.instance.signOut();
        }
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
