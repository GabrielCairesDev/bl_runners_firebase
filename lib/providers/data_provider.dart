import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ModeloDeUsuario? modeloUsuario;

// Método para registrar Data do usuário
  Future<void> registrarUsuarioData(BuildContext context, {required String id, required String nome, required String email}) async {
    // Pegar a coleção Usuários Perfil
    CollectionReference usuariosPerfil = FirebaseFirestore.instance.collection('usuariosPerfil');
    // Pegar padrão pela model
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
    // Salvar a data
    return usuariosPerfil.doc(id).set(modeloDeUsuario.toJson()).then((value) {
      debugPrint('Data Salva');
      // Erro salvar data
    }).catchError(
      (error) {
        debugPrint('Erro salvar data: $error');
      },
    );
  }

  Future<void> pegarUsuario() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Listen to the user document in real time.
      final snapshotListener = _firestore.collection('usuariosPerfil').doc(user.uid).snapshots();

      // When the document changes, update the local modeloUsuario variable.
      snapshotListener.listen((snapshot) {
        if (snapshot.exists) {
          final userData = snapshot.data() as Map<String, dynamic>;
          modeloUsuario = ModeloDeUsuario.fromJson(userData);
          notifyListeners();
        } else {
          modeloUsuario = null;
        }
      });
    } else {
      modeloUsuario = null;
    }
  }
}
