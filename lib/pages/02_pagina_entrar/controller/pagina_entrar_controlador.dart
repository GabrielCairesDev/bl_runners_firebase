import 'package:bl_runners_firebase/providers/interfaces/entrar_use_case.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaEntrarControlador extends ChangeNotifier {
  PaginaEntrarControlador({required this.entrarUseCase});

  final EntrarUseCase entrarUseCase;

  final controladorEmail = TextEditingController();
  final controladorSenha = TextEditingController();

  final GlobalKey<FormState> globalKeyEmailPaginaEntrar = GlobalKey<FormState>();

  bool entrarAutomaticamente = false;
  bool carregando = false;

  Future<String> entrar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final internet = await Connectivity().checkConnectivity();
    if (internet == ConnectivityResult.none) throw 'Sem conexão com a internet!';

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

  resetarValores() {
    controladorEmail.clear();
    controladorSenha.clear();
    entrarAutomaticamente = false;
  }

  atualizarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
