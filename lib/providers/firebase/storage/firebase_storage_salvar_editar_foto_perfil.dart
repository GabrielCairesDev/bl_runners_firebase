import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageEditarFotoPerfil extends ChangeNotifier {
  Future<String?> editarFoto(BuildContext context, {required File? imagemArquivo}) async {
    User? usuarioAtual = FirebaseAuth.instance.currentUser;
    if (usuarioAtual != null) {
      if (imagemArquivo != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("usuarios_foto_perfil/${usuarioAtual.uid}");
        TaskSnapshot uploadTask = await ref.putFile(File(imagemArquivo.path));

        switch (uploadTask.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            throw Exception('Erro ao carregar a foto.');
          case TaskState.canceled:
            throw Exception('Erro ao carregar a foto.');
          case TaskState.error:
            throw Exception('Erro ao carregar a foto.');
          case TaskState.success:
            String downloadUrl = await ref.getDownloadURL();
            usuarioAtual.updatePhotoURL(downloadUrl);
            return downloadUrl.toString();
        }
      }
    } else {
      debugPrint('Usuáruio null.');
      throw Exception('Usuáruio null.');
    }
    return usuarioAtual.photoURL.toString();
  }
}
