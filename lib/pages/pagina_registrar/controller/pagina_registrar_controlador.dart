import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaginaRegistrarControlador extends ChangeNotifier {
  final controladorEmail = TextEditingController();
  final controladorSenha = TextEditingController();
  final controladorCnfirmarSenha = TextEditingController();

  GlobalKey<FormState> globalKeyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeySenha = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeyConfirmarSenha = GlobalKey<FormState>();

  bool esconderSenha = true;
  bool esconderSenha2 = true;
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
    if (globalKeyEmail.currentState!.validate() && globalKeySenha.currentState!.validate() && globalKeyConfirmarSenha.currentState!.validate() && carregando == false) {
      atualizarCarregando();
      registrar(context);
    }
  }

  Future registrar(context) async {
    try {
      final credencial = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: controladorEmail.text, password: controladorCnfirmarSenha.text);
      final ususario = credencial.user;
      final userCollection = FirebaseFirestore.instance.collection('users');

      final cadastroConcluidoFalso = {
        'cadastroConcluido': false,
      };

      await userCollection.doc(ususario!.uid).set(cadastroConcluidoFalso);

      contaCriada(context);
      confirmarEmail();
      resetarValores();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Mensagens.snackBar(context, 'A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        Mensagens.snackBar(context, 'Este e-mail já está em uso.');
      } else {
        Mensagens.snackBar(context, 'Erro durante o registro: ${e.message}');
      }
    } catch (e) {
      Mensagens.snackBar(context, 'Erro desconhecido: $e');
    }
    atualizarCarregando();
  }

  contaCriada(context) {
    Mensagens.caixaDeDialogo(
      context,
      titulo: "Parabéns!",
      texto: 'Sua conta foi criada com sucesso. Verifique o seu e-mail!',
      textoBotao: 'OK',
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> confirmarEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  resetarValores() {
    controladorEmail.clear();
    controladorSenha.clear();
    controladorCnfirmarSenha.clear();
    esconderSenha = true;
    esconderSenha2 = true;
  }

  atualizarCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
