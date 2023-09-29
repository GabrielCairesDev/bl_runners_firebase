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
    final usuarioAtual = FirebaseAuth.instance.currentUser;

    if (usuarioAtual != null) {
      await _salvarFoto(imagemArquivo: imagemArquivo, usuarioAtual: usuarioAtual).then((value) async {
        final modeloDeUsuario = ModeloDeUsuario(
          id: usuarioAtual.uid,
          nome: nome,
          email: usuarioAtual.email.toString(),
          fotoUrl: value.toString(),
          genero: genero,
          master: false,
          admin: false,
          autorizado: false,
          cadastroConcluido: true,
          dataNascimento: nascimento,
        );

        await FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid.toString()).update(modeloDeUsuario.toJson()).then(
          (value) {
            return 'Cadastro concluido com sucesso!';
          },
        ).catchError(
          (error) {
            throw 'Erro ao concluir cadastro:\n$error';
          },
        );
      }).catchError((onError) {
        throw 'Erro ao carregar foto:\n$onError';
      });
    } else {
      throw 'Erro ao concluir cadastro:\nUsuário null.';
    }
    return '';
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
