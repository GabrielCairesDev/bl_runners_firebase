import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/modelo_de_usuario.dart';

class UserProvider extends ChangeNotifier {
  ModeloDeUsuario? _usuarioModelo;
  ModeloDeUsuario? get usuarioModelo => _usuarioModelo;

  Future<void> pegarUsuarioAtualizado(User? user) async {
    try {
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get();
        if (userSnapshot.exists) {
          _usuarioModelo = ModeloDeUsuario.fromJson(userSnapshot.data() as Map<String, dynamic>);
        } else {
          _usuarioModelo = null;
        }
        notifyListeners();
      } else {
        _usuarioModelo = null;
      }
    } catch (e) {
      await _erroMensagem('Erro ao obter o usuário: $e');
      _usuarioModelo = null;
    }
  }

  Future<void> _erroMensagem(String mensagem) async => debugPrint('Erro: $mensagem');
}
