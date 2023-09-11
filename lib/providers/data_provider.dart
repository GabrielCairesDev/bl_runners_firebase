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
    return usuariosPerfil.doc(id).set(modeloDeUsuario.toJson()).then(
      (value) {
        debugPrint('Data Salva');
      },
    ).catchError(
      // Erro ao Salvar a  Data
      (error) {
        debugPrint('Erro salvar data: $error');
      },
    );
  }

  // Metodo para pegar usuário Data
  Future<void> pegarUsuarioData() async {
    // Pegar usuário atual
    final user = FirebaseAuth.instance.currentUser;

    // Verificar se é nulo
    if (user != null) {
      // Pegar o documento com os dados
      final userData = _firestore.collection('usuariosPerfil').doc(user.uid).snapshots();

      // Organizar os dados
      userData.listen(
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
