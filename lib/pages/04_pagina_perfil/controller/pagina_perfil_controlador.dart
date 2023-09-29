import 'package:bl_runners_firebase/providers/interfaces/sair_use_case.dart';
import 'package:flutter/material.dart';

class PaginaPerfilControlador extends ChangeNotifier {
  final SairUseCase sairUseCase;

  PaginaPerfilControlador({required this.sairUseCase});
  Future<String> sair() async {
    final resultado = await sairUseCase();
    return resultado;
  }
}
