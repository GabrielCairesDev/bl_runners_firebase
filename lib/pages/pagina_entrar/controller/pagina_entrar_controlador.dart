import 'package:bl_runners_firebase/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaEntrarControlador extends ChangeNotifier {
  final controladorEmail = TextEditingController(text: 'gabriel.araujo.caires@gmail.com');
  final controladorSenha = TextEditingController(text: 'gabriel');

  final globalKeyEmailEntrar = GlobalKey<FormState>();
  final globalKeySenhaEntrar = GlobalKey<FormState>();

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
    if (globalKeyEmailEntrar.currentState!.validate() && globalKeySenhaEntrar.currentState!.validate() && carregando == false) {
      entrar(context);
    }
  }

  entrar(context) {
    atualizarCarregando();
    final authprovider = Provider.of<AuthProvider>(context, listen: false);
    authprovider.entrar(context, controladorEmail.text, controladorSenha.text, entradaAutomatica);
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
}
