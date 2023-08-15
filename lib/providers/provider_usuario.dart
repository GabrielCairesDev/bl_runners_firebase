import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/modelo_de_usuario.dart';

class ProviderUsuario extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;
  ModeloDeUsuario? usuario;
  Future atualizarUsuario() async {
    if (user != null) {
      final usuarioDados = await FirebaseFirestore.instance.collection('usuarios').doc(user!.uid).get();
      usuario = ModeloDeUsuario.fromJson(usuarioDados.data() as Map<String, dynamic>);
      notifyListeners();
    }
  }
}
