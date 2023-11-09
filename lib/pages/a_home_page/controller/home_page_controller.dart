import 'package:bl_runners_app/providers/interfaces/entrar_automaticamente_use_case.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageControlador extends ChangeNotifier {
  final EntrarAutomaticamenteUseCase entrarAutomaticamenteUseCase;

  HomePageControlador({required this.entrarAutomaticamenteUseCase});

  Future<String> entrarAutomaticamente() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool entrarAutomaticamente =
        prefs.getBool('entrarAutomaticamente') ?? false;

    final resultado = await entrarAutomaticamenteUseCase(
        entrarAutomaticamente: entrarAutomaticamente);
    return resultado;
  }
}
