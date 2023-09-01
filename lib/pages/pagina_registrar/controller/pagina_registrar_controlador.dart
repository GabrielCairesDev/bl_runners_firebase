import 'package:bl_runners_firebase/providers/auth_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
      criarUsarioProvider(context);
      // registrar(context);
    }
  }

  criarUsarioProvider(context) {
    atualizarCarregando();
    final authprovider = Provider.of<AuthProvider>(context, listen: false);
    authprovider.criarUsuario(context, controladorEmail.text, controladorCnfirmarSenha.text, controladorNome.text);
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
