import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_usuarios_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePegarUsuarios extends PegarUsuariosUseCase {
  final Map<String, ModeloDeUsuario> _usuarios = {};
  List<ModeloDeUsuario> get listaUsuarios => _usuarios.values.toList();

  @override
  Future<List<ModeloDeUsuario>> call(ModeloDeUsuario modeloDeUsuario, List<ModeloDeAtividade> listaDeAtividades) async {
    _usuarios.clear();
    listaUsuarios.clear();

    for (var index = 0; index < listaDeAtividades.length; index++) {
      final atividade = listaDeAtividades[index];
      final resultado = await FirebaseFirestore.instance.collection('usuarios').doc(atividade.idUsuario).get();

      if (resultado.exists) {
        var usuarioData = resultado.data() as Map<String, dynamic>;
        var modeloUsuario = ModeloDeUsuario.fromJson(usuarioData);
        _usuarios[atividade.idUsuario] = modeloUsuario;
      }
    }
    return listaUsuarios;
  }
}
// for (var atividade in listaDeAtividades) {
    //   final resultado = await FirebaseFirestore.instance.collection('users').doc(atividade.idUsuario).get();

    //   if (resultado.exists) {
    //     var usuarioJson = resultado.data() as Map<String, dynamic>;
    //     var usuario = ModeloDeUsuario.fromJson(usuarioJson);
    //     _usuarios[atividade.idUsuario] = usuario;
    //   }
    // }