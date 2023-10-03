import 'dart:io';

import 'package:bl_runners_firebase/providers/interfaces/salvar_foto_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseSalvarFoto extends SalvarFotoUseCase {
  @override
  Future<String> call({required File? imagemArquivo, User? usuarioAtual}) async {
    if (imagemArquivo != null) {
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("usuarios_foto_perfil/${usuarioAtual!.uid}");
        await ref.putFile(imagemArquivo);

        String downloadUrl = await ref.getDownloadURL();
        await usuarioAtual.updatePhotoURL(downloadUrl);
        return downloadUrl;
      } catch (e) {
        throw '$e';
      }
    } else {
      throw 'Foto Null!';
      // return usuarioAtual!.photoURL.toString();
    }
  }
}
