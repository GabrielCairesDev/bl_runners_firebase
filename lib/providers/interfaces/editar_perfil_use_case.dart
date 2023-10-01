import 'dart:io';

import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';

abstract class EditarPerfil {
  Future<String> call(
    ModeloDeUsuario modeloDeUsuario, {
    required File? imagemArquivo,
    required String nome,
    required String genero,
    DateTime? nascimentoData,
  });
}
