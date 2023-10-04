import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePegarAtividades extends PegarAtividadesUseCase {
  final Map<String, ModeloDeAtividade> _atividades = {};
  List<ModeloDeAtividade> get listaAtividades => _atividades.values.toList();

  @override
  Future<List<ModeloDeAtividade>> call(ModeloDeAtividade modeloDeAtividade, int ano, int mes) async {
    listaAtividades.clear();
    _atividades.clear();
    try {
      final atividades =
          await FirebaseFirestore.instance.collection('atividades').where('ano', isEqualTo: ano).where('mes', isEqualTo: mes).get();

      if (atividades.docs.isEmpty) {
        throw 'Não exite registros em: $mes/$ano';
      }

      for (var element in atividades.docs) {
        var atividade = ModeloDeAtividade.fromJson(element.data());
        if (atividade.mes == mes || atividade.ano == ano) {
          _atividades[element.id] = atividade;
        }
      }

      return listaAtividades;
    } catch (e) {
      throw '$e';
    }
  }
}
