import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:go_router/go_router.dart';

// import '../../../routes/rotas.dart';

class PaginaRegistrarControlador extends ChangeNotifier {
  final controladorNome = TextEditingController();
  final controladorEmail = TextEditingController();
  final controladorSenha = TextEditingController();
  final controladorCnfirmarSenha = TextEditingController();

  final globalKeyNomeRegistrar = GlobalKey<FormState>();
  final globalKeyEmailRegistrar = GlobalKey<FormState>();
  final globalKeySenhaRegistrar = GlobalKey<FormState>();
  final globalKeyConfirmarSenhaRegistrar = GlobalKey<FormState>();

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
    if (globalKeyEmailRegistrar.currentState!.validate() &&
        globalKeySenhaRegistrar.currentState!.validate() &&
        globalKeyConfirmarSenhaRegistrar.currentState!.validate() &&
        carregando == false) {
      atualizarCarregando();
      registrar(context);
    }
  }

  Future registrar(context) async {
    try {
      final usuario = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: controladorEmail.text, password: controladorCnfirmarSenha.text);
      await usuario.user!.updateDisplayName(controladorNome.text);

      final modeloDeUsuario = ModeloDeUsuario(
        id: usuario.user!.uid,
        nome: usuario.user!.displayName.toString(),
        email: usuario.user!.email.toString(),
        fotoUrl: '',
        genero: '',
        master: false,
        admin: false,
        autorizado: false,
        cadastroConcluido: false,
        dataNascimento: DateTime.now(),
      );

      FirebaseFirestore.instance.collection('usuarios').doc(usuario.user!.uid).set(modeloDeUsuario.toJson());

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
      onPressed: () async => Navigator.of(context).pop(),
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
