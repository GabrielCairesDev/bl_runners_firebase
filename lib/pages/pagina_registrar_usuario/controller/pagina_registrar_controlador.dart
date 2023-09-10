import 'package:bl_runners_firebase/providers/auth_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarControlador extends ChangeNotifier {
  final controladorNome = TextEditingController(text: 'Gabriel');
  final controladorEmail = TextEditingController();
  final controladorSenha = TextEditingController(text: 'gabriel');
  final controladorCnfirmarSenha = TextEditingController(text: 'gabriel');

  final GlobalKey<FormState> globalKeyPaginaRegistrar = GlobalKey<FormState>();

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
    if (globalKeyPaginaRegistrar.currentState!.validate() && carregando == false) {
      criarUsarioProvider(context);
      atualizarCarregando();
    }
  }

  criarUsarioProvider(context) {
    final controladorAuthprovider = Provider.of<AuthProvider>(context, listen: false);
    controladorAuthprovider.registrar(
      context,
      email: controladorEmail.text.trim(),
      senha: controladorCnfirmarSenha.text.trim(),
      nome: controladorNome.text,
    );
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
