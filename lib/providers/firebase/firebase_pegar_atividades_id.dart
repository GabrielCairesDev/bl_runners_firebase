import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_id_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePegarAtividadesID extends PegarAtividadesIdUsuarioUseCase {
  final Map<String, ModeloDeAtividade> _atividades = {};
  List<ModeloDeAtividade> get listaAtividades => _atividades.values.toList();

  @override
  Future<List<ModeloDeAtividade>> call(ModeloDeAtividade modeloDeAtividade, String idUsuario) async {
    listaAtividades.clear();
    _atividades.clear();
    try {
      final atividades = await FirebaseFirestore.instance.collection('atividades').where('idUsuario', isEqualTo: idUsuario).get();

      if (atividades.docs.isEmpty) throw 'Não exite registros na id: $idUsuario';

      for (var element in atividades.docs) {
        var atividade = ModeloDeAtividade.fromJson(element.data());

        _atividades[element.id] = atividade;
      }

      return listaAtividades;
    } catch (e) {
      throw '$e';
    }
  }
}
