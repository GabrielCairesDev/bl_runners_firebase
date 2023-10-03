import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

abstract class SalvarFotoUseCase {
  Future<String> call({required File? imagemArquivo, User? usuarioAtual});
}
