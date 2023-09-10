import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  // Registrar Data do usuário
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

  Future<Map<String, dynamic>?> lerUsuario(String userId) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$userId').get();
    try {
      final DocumentSnapshot snapshot = await _firestore.collection('usuariosPerfil').doc(userId).get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (error) {
      print('Erro ao ler usuário: $error');
      rethrow;
    }
  }
}
