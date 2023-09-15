import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseFireStoreSalvarPerfil extends ChangeNotifier {
  Future<void> salvarPerfil(BuildContext context, {required String id, required String nome, required String email}) async {
    User? usuarioAtual = FirebaseAuth.instance.currentUser;

    if (usuarioAtual != null) {
      final modeloDeUsuario = ModeloDeUsuario(
        id: id,
        nome: nome,
        email: email,
        fotoUrl: '',
        genero: 'Masculino',
        master: false,
        admin: false,
        autorizado: false,
        cadastroConcluido: false,
        dataNascimento: DateTime.now(),
      );
      final documentoFirebase = await FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid.toString()).get();

      if (documentoFirebase.exists == false) await documentoFirebase.reference.set({});

      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuarioAtual.uid.toString())
          .collection('perfil')
          .doc('dados')
          .set(modeloDeUsuario.toJson())
          .then(
        (value) {
          debugPrint('Perfil salvar com sucesso!');
        },
      ).catchError(
        (error) {
          debugPrint('Erro ao salvar perfil: $error');
        },
      );
    } else {
      debugPrint('Erro ao salvar perfil: Usuário null');
    }
  }
}
