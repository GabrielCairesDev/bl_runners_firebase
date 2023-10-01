import 'dart:io';

import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/concluir_cadastro_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseFireStoreConcluirCadastro extends ConcluirCadastroUseCase {
  @override
  Future<String> call(
    ModeloDeUsuario modeloDeUsuario, {
    required imagemArquivo,
    required String nome,
    required String genero,
    required DateTime nascimento,
  }) async {
    try {
      final usuarioAtual = FirebaseAuth.instance.currentUser;
      if (usuarioAtual == null) throw 'Erro ao concluir cadastro:\nUsuário nulo.';

      final fotoUrl = await _salvarFoto(imagemArquivo: imagemArquivo, usuarioAtual: usuarioAtual);

      final novoModeloDeUsuario = ModeloDeUsuario(
        id: usuarioAtual.uid,
        nome: nome,
        email: usuarioAtual.email.toString(),
        fotoUrl: fotoUrl.toString(),
        genero: genero,
        master: false,
        admin: false,
        autorizado: false,
        cadastroConcluido: true,
        dataNascimento: nascimento,
      );

      final documento = await FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid).get();

      if (!documento.exists) FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid).set({});

      await FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid).update(novoModeloDeUsuario.toJson());

      return 'Cadastro concluído com sucesso!';
    } catch (onError) {
      throw 'Erro ao concluir cadastro:\n$onError';
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
      throw 'Foto Null!';
    }
  }
}
