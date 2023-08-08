import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaginaRegistrarControlador extends ChangeNotifier {
  final controladorNome = TextEditingController();
  final controladorEmail = TextEditingController();
  final controladorSenha = TextEditingController();
  final controladorCnfirmarSenha = TextEditingController();

  GlobalKey<FormState> globalKeyNome = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeySenha = GlobalKey<FormState>();
  GlobalKey<FormState> globalKeyConfirmarSenha = GlobalKey<FormState>();

  bool esconderSenha = true;
  bool esconderSenha2 = true;
  bool carregando = false;

  String? validadorNome(String? value) {
    if (value!.isEmpty) {
      return 'Campo obrigatório!';
    }
    return null;
  }

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

      final usuarios = FirebaseFirestore.instance.collection('usuarios');
      final modeloDeUsuario = ModeloDeUsuario(
        cadastroConcluido: false,
        master: false,
        admin: false,
        convidado: false,
        autorizado: false,
        tenis: 0,
        genero: 'Não Definido',
        camiseta: 'Não Definido',
        dataMascimento: DateTime.now(),
      );

      await usuarios.doc(ususario!.uid).set(modeloDeUsuario.toMap());
      await ususario.updateDisplayName(controladorNome.text);

      mensagemContaCriada(context);
      enviarConfirmarcaoEmail();
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

  mensagemContaCriada(context) {
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

  Future<void> enviarConfirmarcaoEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  resetarValores() {
    controladorNome.clear();
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
