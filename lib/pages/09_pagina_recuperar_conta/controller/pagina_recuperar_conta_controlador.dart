import 'package:bl_runners_firebase/providers/interfaces/recuperar_conta_use_case.dart';
import 'package:flutter/material.dart';

class PaginaRecuperarContaControlador extends ChangeNotifier {
  PaginaRecuperarContaControlador({required this.recuperarContaUseCase});

  final RecuperarContaUseCase recuperarContaUseCase;

  final controladorEmail = TextEditingController();
  final GlobalKey<FormState> globalKeyEmailPaginaRecuperar = GlobalKey<FormState>();

  bool carregando = false;

  Future<String> recuperarConta() async {
    if (globalKeyEmailPaginaRecuperar.currentState!.validate()) {
      try {
        atualizarEstadoCarregando();
        final resultado = await recuperarContaUseCase(email: controladorEmail.text.trim());
        controladorEmail.clear();
        return resultado;
      } catch (e) {
        rethrow;
      } finally {
        atualizarEstadoCarregando();
      }
    }
    throw 'Digite o e-mail!';
  }

  atualizarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
