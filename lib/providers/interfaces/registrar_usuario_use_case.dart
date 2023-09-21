import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:flutter/material.dart';

abstract class RegistrarUsuarioUseCase {
  Future<bool> call(
    ModeloDeUsuario modeloDeUsuario, {
    required String email,
    required String senha,
    required String nome,
  });
}
