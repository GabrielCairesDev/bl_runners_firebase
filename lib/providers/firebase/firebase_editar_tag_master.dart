import 'package:bl_runners_firebase/providers/interfaces/editar_tag_master_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseEditarTagMaster extends EditarTagMasterUseCase {
  @override
  Future<String> call({
    required String idUsuario,
    required bool master,
  }) async {
    try {
      final documento = await FirebaseFirestore.instance.collection('usuarios').doc(idUsuario).get();

      if (!documento.exists) throw 'Não encontrado no banco de dados';

      await FirebaseFirestore.instance.collection('usuarios').doc(idUsuario).update({'master': master});

      return 'Atualização concluída!';
    } catch (e) {
      return e.toString();
    }
  }
}
