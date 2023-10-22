import 'dart:io';

abstract class EditarPerfil {
  Future<String> call({
    required File? imagemArquivo,
    required String nome,
    required String genero,
    DateTime? nascimentoData,
  });
}
