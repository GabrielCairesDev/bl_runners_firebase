import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PegarUsuario extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ModeloDeUsuario? modeloUsuario;

  Future<void> pegarUsuarioData() async {
    final usuarioAtual = FirebaseAuth.instance.currentUser;

    if (usuarioAtual != null) {
      final documento = _firestore.collection('usuarios').doc(usuarioAtual.uid).snapshots();

      documento.listen(
        (snapshot) {
          if (snapshot.exists) {
            final data = snapshot.data() as Map<String, dynamic>;
            modeloUsuario = ModeloDeUsuario.fromJson(data);
            notifyListeners();
          } else {
            modeloUsuario = null;
          }
        },
      );
    } else {
      modeloUsuario = null;
    }
  }
}
