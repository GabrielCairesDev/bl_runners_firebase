import 'package:bl_runners_firebase/providers/interfaces/sair_use_case.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaPerfilControlador extends ChangeNotifier {
  final SairUseCase sairUseCase;

  PaginaPerfilControlador({required this.sairUseCase});
  Future<String> sair() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final resultado = await sairUseCase();
      prefs.setBool("entrarAutomaticamente", false);
      return resultado;
    } catch (e) {
      throw 'Erro ao tentar sair: $e!';
    }
  }
}
