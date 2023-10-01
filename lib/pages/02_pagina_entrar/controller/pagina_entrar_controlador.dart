import 'package:bl_runners_firebase/providers/interfaces/entrar_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/recuperar_conta_use_case.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class PaginaEntrarControlador extends ChangeNotifier {
  final EntrarUseCase entrarUseCase;
  final RecuperarContaUseCase recuperarContaUseCase;

  PaginaEntrarControlador({required this.entrarUseCase, required this.recuperarContaUseCase});
  final controladorEmail = TextEditingController(text: 'gabriel.araujo.caires@gmail.com');
  final controladorSenha = TextEditingController(text: 'gabriel');
  final controladorEmailRecuperar = TextEditingController();

  final GlobalKey<FormState> globalKeyEmailPaginaEntrar = GlobalKey<FormState>();

  bool esconderSenha = true;
  bool entrarAutomaticamente = false;
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

  Future<String> entrar() async {
    atualizarEstadoCarregando();

    final reultado = await Connectivity().checkConnectivity();
    if (reultado == ConnectivityResult.none) throw 'Sem conexão com a internet!';

    if (globalKeyEmailPaginaEntrar.currentState!.validate()) {
      final resultado = await entrarUseCase(
        email: controladorEmail.text.trim(),
        senha: controladorSenha.text,
      );
      return resultado;
    }
    throw 'Preencha todos os dados!';
  }

  Future<String> recuperarConta() async {
    atualizarEstadoCarregando();
    return await recuperarContaUseCase(email: controladorEmailRecuperar.text.trim());
  }

  resetarValores() {
    controladorEmail.clear();
    controladorSenha.clear();
    controladorEmailRecuperar.clear();
    esconderSenha = true;
    entrarAutomaticamente = false;
  }

  atualizarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
