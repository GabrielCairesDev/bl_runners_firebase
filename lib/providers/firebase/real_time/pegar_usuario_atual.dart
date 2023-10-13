import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PegarUsuarioAtual extends ChangeNotifier {
  ModeloDeUsuario? usuarioAtual;

  Future<void> pegarUsuarioAtual() async {
    final usuario = FirebaseAuth.instance.currentUser;

    if (usuario != null) {
      final documento = FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).snapshots();

      documento.listen(
        (snapshot) {
          if (snapshot.exists) {
            final data = snapshot.data() as Map<String, dynamic>;
            usuarioAtual = ModeloDeUsuario.fromJson(data);
            notifyListeners();
          } else {
            usuarioAtual = null;
          }
        },
      );
    } else {
      usuarioAtual = null;
    }
  }
}
