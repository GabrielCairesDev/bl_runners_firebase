import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_id_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebasePegarAtividadesID extends PegarAtividadesIdUsuarioUseCase {
  final Map<String, ModeloDeAtividade> _atividades = {};
  List<ModeloDeAtividade> get listaAtividades => _atividades.values.toList();

  @override
  Future<List<ModeloDeAtividade>> call(ModeloDeAtividade modeloDeAtividade, String idUsuario) async {
    listaAtividades.clear();
    _atividades.clear();

    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.reload();
      try {
        final atividades =
            await FirebaseFirestore.instance.collection('atividades').where('idUsuario', isEqualTo: idUsuario).get();

        if (atividades.docs.isEmpty) throw 'Não exite registros na id: $idUsuario';

        for (var element in atividades.docs) {
          var atividade = ModeloDeAtividade.fromJson(element.data());

          _atividades[element.id] = atividade;
        }

        return listaAtividades;
      } catch (e) {
        throw '$e';
      }
    } else {
      throw 'Usuário Null';
    }
  }
}
