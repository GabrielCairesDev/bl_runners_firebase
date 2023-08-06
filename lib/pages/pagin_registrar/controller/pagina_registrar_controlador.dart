import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaginaRegistrarControlador extends ChangeNotifier {
  final controladorEmail = TextEditingController();
  final controladorSenha = TextEditingController();
  final controladorCnfirmarSenha = TextEditingController();

  GlobalKey<FormState> globalKeyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeySenha = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeyConfirmarSenha = GlobalKey<FormState>();

  bool esconderSenha = true;
  bool esconderSenha2 = true;

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
    } else if (value.length < 6) {
      return 'Senha curta!';
    }
    return null;
  }

  String? validadorConfirmarSenha(String? value) {
    if (value!.isEmpty) {
      return 'Campo obrigatório!';
    } else if (value != controladorSenha.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  validarCampos(context) {
    if (globalKeyEmail.currentState!.validate() &&
        globalKeySenha.currentState!.validate() &&
        globalKeyConfirmarSenha.currentState!.validate()) {
      registrar(context);
    }
  }

  Future<void> registrar(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: controladorEmail.text,
          password: controladorCnfirmarSenha.text);
      contaCriada(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Mensagens.snackBar(context, 'A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        Mensagens.snackBar(context, 'Este e-mail já está em uso');
      } else {
        Mensagens.snackBar(context, 'Erro durante o registro: ${e.message}');
      }
    } catch (e) {
      Mensagens.snackBar(context, 'Erro desconhecido: ${e.toString()}');
    }
  }

  contaCriada(context) {
    Mensagens.caixaDeDialogo(
      context,
      titulo: "Parabéns!",
      texto: 'Sua conta foi criada com sucesso.',
      textoBotao: 'OK',
      onPressed: () {
        confirmarEmail();
      },
    );
  }

  Future<void> confirmarEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
}
