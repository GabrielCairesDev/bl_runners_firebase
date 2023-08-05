import 'package:flutter/widgets.dart';

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

  validarCampos() {
    if (globalKeyEmail.currentState!.validate() &&
        globalKeySenha.currentState!.validate() &&
        globalKeyConfirmarSenha.currentState!.validate()) {
      print('tudo certo');
    }
  }
}
