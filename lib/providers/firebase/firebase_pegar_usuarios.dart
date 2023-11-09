import 'package:bl_runners_app/models/modelo_de_atividade.dart';
import 'package:bl_runners_app/models/modelo_de_usuario.dart';
import 'package:bl_runners_app/providers/interfaces/pegar_usuarios_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebasePegarUsuarios extends PegarUsuariosUseCase {
  final Map<String, ModeloDeUsuario> _usuarios = {};
  List<ModeloDeUsuario> get listaUsuarios => _usuarios.values.toList();

  @override
  Future<List<ModeloDeUsuario>> call(ModeloDeUsuario modeloDeUsuario,
      List<ModeloDeAtividade> listaDeAtividades) async {
    _usuarios.clear();
    listaUsuarios.clear();

    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.reload();

      for (var index = 0; index < listaDeAtividades.length; index++) {
        final atividade = listaDeAtividades[index];
        final resultado = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(atividade.idUsuario)
            .get();

        if (resultado.exists) {
          var usuarioData = resultado.data() as Map<String, dynamic>;
          var modeloUsuario = ModeloDeUsuario.fromJson(usuarioData);
          _usuarios[atividade.idUsuario] = modeloUsuario;
        }
      }
      return listaUsuarios;
    } else {
      throw 'Usuário Null';
    }
  }
}
