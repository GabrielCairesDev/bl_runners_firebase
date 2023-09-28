import 'package:bl_runners_firebase/providers/interfaces/entrar_automaticamente_use_case.dart';
import 'package:flutter/material.dart';

class HomePageController extends ChangeNotifier {
  final EntrarAutomaticamenteUseCase entrarAutomaticamenteUseCase;

  HomePageController({required this.entrarAutomaticamenteUseCase});

  Future<String> entrarAutomaticamente() async {
    final resultado = await entrarAutomaticamenteUseCase();
    return resultado;
  }
}
