import 'dart:io';

import 'package:bl_runners_app/providers/interfaces/concluir_cadastro_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseConcluirCadastro extends ConcluirCadastroUseCase {
  @override
  Future<String> call({
    required File? imagemArquivo,
    required String nome,
    required String genero,
    Timestamp? dataNascimento,
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.reload();

      try {
        final documento = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(currentUser.uid)
            .get();
        if (!documento.exists) throw 'Erro no banco de dados!';

        String fotoUrl = await _salvarFoto(
            imagemArquivo: imagemArquivo, usuarioAtual: currentUser);

        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(currentUser.uid)
            .update({
          'autorizado': true,
          'cadastroConcluido': true,
          'nome': nome,
          'genero': genero,
          'dataNascimento': dataNascimento,
          'fotoUrl': fotoUrl,
        });

        return 'Cadastro concluído com sucesso!';
      } catch (onError) {
        throw 'Erro ao concluir cadastro:\n$onError';
      }
    } else {
      throw 'Usuário Null';
    }
  }

  Future<String> _salvarFoto(
      {required File? imagemArquivo, User? usuarioAtual}) async {
    if (imagemArquivo != null) {
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref =
            storage.ref().child("usuarios_foto_perfil/${usuarioAtual!.uid}");
        await ref.putFile(imagemArquivo);

        String downloadUrl = await ref.getDownloadURL();
        await usuarioAtual.updatePhotoURL(downloadUrl);
        return downloadUrl;
      } catch (e) {
        throw '$e';
      }
    } else {
      throw 'Foto Null!';
    }
  }
}
