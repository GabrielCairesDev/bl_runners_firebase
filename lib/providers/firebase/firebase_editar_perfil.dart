import 'dart:io';

import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/editar_perfil_use_case.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseEditarPerfil extends EditarPerfil {
  @override
  Future<String> call(
    ModeloDeUsuario modeloDeUsuario, {
    required File? imagemArquivo,
    required String nome,
    required String genero,
    DateTime? nascimentoData,
  }) async {
    try {
      User? usuarioAtual = FirebaseAuth.instance.currentUser;

      if (usuarioAtual == null) throw 'Erro ao editar perfil: Usuário null.';

      String fotoUrl = await _salvarFoto(imagemArquivo: imagemArquivo, usuarioAtual: usuarioAtual);

      final documento = await FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid).get();

      if (!documento.exists) FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid).set({});

      Timestamp? dataNascimentoTimestamp;
      if (nascimentoData != null) {
        DateTime dataNascimentoComFusoHorario =
            nascimentoData.add(Duration(hours: nascimentoData.timeZoneOffset.inHours)); // Adiciona o deslocamento de fuso horário local
        dataNascimentoTimestamp = Timestamp.fromDate(dataNascimentoComFusoHorario);
      }

      await FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid).update({
        'nome': nome,
        'genero': genero,
        'dataNascimento': dataNascimentoTimestamp,
        'fotoUrl': fotoUrl,
      });

      return 'Perfil editado com sucesso!';
    } catch (error) {
      throw 'Erro ao editar perfil: $error';
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
