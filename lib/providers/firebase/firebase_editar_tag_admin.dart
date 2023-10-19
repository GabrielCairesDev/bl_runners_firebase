import 'package:bl_runners_firebase/providers/interfaces/editar_tag_admin_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseEditarTagAdmin extends EditarTagAdminUseCase {
  @override
  Future<String> call({
    required String idUsuario,
    required bool admin,
  }) async {
    try {
      final documento = await FirebaseFirestore.instance.collection('usuarios').doc(idUsuario).get();

      if (!documento.exists) throw 'Não encontrado no banco de dados';

      await FirebaseFirestore.instance.collection('usuarios').doc(idUsuario).update({'admin': admin});

      return 'Atualização concluída!';
    } catch (e) {
      return e.toString();
    }
  }
}
