import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ConcluirCadastroUseCase {
  Future<String> call({
    required File? imagemArquivo,
    required String nome,
    required String genero,
    Timestamp dataNascimento,
  });
}
