import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_todos_usuarios_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebasePegarTodosUsuario extends PegarTodosUsuariosUseCase {
  final Map<String, ModeloDeUsuario> _todosUsuarios = {};
  List<ModeloDeUsuario> get todosUsuarios => _todosUsuarios.values.toList();

  @override
  Future<List<ModeloDeUsuario>> call(ModeloDeUsuario modeloDeUsuario) async {
    _todosUsuarios.clear();

    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.reload();
      try {
        final usuarios = await FirebaseFirestore.instance.collection('usuarios').get();
        if (usuarios.docs.isEmpty) throw 'Não existem usuários registrados';

        for (var usuario in usuarios.docs) {
          final usuarioData = usuario.data();
          final modeloDeUsuario = ModeloDeUsuario.fromJson(usuarioData);
          _todosUsuarios[usuario.id] = modeloDeUsuario;
        }
        return todosUsuarios;
      } catch (e) {
        rethrow;
      }
    } else {
      throw 'Usuário Null';
    }
  }
}
