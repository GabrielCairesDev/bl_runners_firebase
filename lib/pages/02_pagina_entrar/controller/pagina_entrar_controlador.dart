import 'package:bl_runners_firebase/providers/interfaces/entrar_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/recuperar_conta_use_case.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<String> entrar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final reultado = await Connectivity().checkConnectivity();
    if (reultado == ConnectivityResult.none) throw 'Sem conexão com a internet!';

    if (globalKeyEmailPaginaEntrar.currentState!.validate()) {
      try {
        atualizarEstadoCarregando();
        final resultado = await entrarUseCase(
          email: controladorEmail.text.trim(),
          senha: controladorSenha.text,
        );
        prefs.setBool("entrarAutomaticamente", entrarAutomaticamente);
        resetarValores();
        return resultado;
      } catch (e) {
        rethrow;
      } finally {
        atualizarEstadoCarregando();
      }
    }
    throw 'Preencha todos os dados!';
  }

  Future<String> recuperarConta() async {
    if (controladorEmailRecuperar.text.isNotEmpty) {
      try {
        atualizarEstadoCarregando();
        final resultado = await recuperarContaUseCase(email: controladorEmailRecuperar.text.trim());
        return resultado;
      } catch (e) {
        rethrow;
      } finally {
        atualizarEstadoCarregando();
        resetarValores();
      }
    }
    throw 'Digite o seu e-mail';
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
