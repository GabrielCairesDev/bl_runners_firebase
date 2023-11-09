import 'package:bl_runners_app/providers/interfaces/editar_tag_admin_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseEditarTagAdmin extends EditarTagAdminUseCase {
  @override
  Future<String> call({
    required String listaUsuarioId,
    required bool listaUsuarioAdmin,
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await currentUser.reload();
      try {
        final documento = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(listaUsuarioId)
            .get();

        if (!documento.exists) throw 'Não encontrado no banco de dados';

        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(listaUsuarioId)
            .update({'admin': listaUsuarioAdmin});

        return 'Atualização concluída!';
      } catch (e) {
        return e.toString();
      }
    } else {
      throw 'Usuário null.';
    }
  }
}
