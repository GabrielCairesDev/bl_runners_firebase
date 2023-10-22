import 'dart:io';

import 'package:bl_runners_firebase/providers/interfaces/editar_perfil_use_case.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseEditarPerfil extends EditarPerfil {
  @override
  Future<String> call({
    required File? imagemArquivo,
    required String nome,
    required String genero,
    DateTime? nascimentoData,
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.reload();

      try {
        String fotoUrl = await _salvarFoto(imagemArquivo: imagemArquivo, usuarioAtual: currentUser);

        final documento = await FirebaseFirestore.instance.collection('usuarios').doc(currentUser.uid).get();

        if (!documento.exists) FirebaseFirestore.instance.collection('usuarios').doc(currentUser.uid).set({});

        Timestamp? dataNascimento;
        if (nascimentoData != null) {
          DateTime dataNascimentoComFusoHorario = nascimentoData.add(Duration(hours: nascimentoData.timeZoneOffset.inHours));
          dataNascimento = Timestamp.fromDate(dataNascimentoComFusoHorario);
        }

        await FirebaseFirestore.instance.collection('usuarios').doc(currentUser.uid).update({
          'nome': nome,
          'genero': genero,
          'dataNascimento': dataNascimento,
          'fotoUrl': fotoUrl,
        });

        return 'Perfil editado com sucesso!';
      } catch (error) {
        throw 'Erro ao editar perfil: $error';
      }
    } else {
      throw 'Usuário null.';
    }
  }

  Future<String> _salvarFoto({required File? imagemArquivo, User? usuarioAtual}) async {
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
      return usuarioAtual!.photoURL.toString();
    }
  }
}
