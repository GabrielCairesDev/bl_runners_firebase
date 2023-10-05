import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PegarUsuarioAtual extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ModeloDeUsuario? usuarioAtual;

  Future<void> pegarUsuarioData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final documento = _firestore.collection('usuarios').doc(user.uid).snapshots();

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
