import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePegarAtividades extends PegarAtividadesUseCase {
  final Map<String, ModeloDeAtividade> _atividades = {};
  List<ModeloDeAtividade> get listaAtividades => _atividades.values.toList();

  @override
  Future<List> call(ModeloDeAtividade modeloDeAtividade, {required int ano, required int mes, required lista}) async {
    try {
      final atividades = await FirebaseFirestore.instance.collection('atividades').where('ano', isEqualTo: ano).get();

      if (atividades.docs.isEmpty) {
        _atividades.clear();
        throw 'Não exite registros em: $mes/$ano';
      }

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
