import 'package:bl_runners_firebase/providers/interfaces/excluir_atividade_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExcluirAtividade extends ExcluirAtividadeUseCase {
  @override
  Future<String> call(String listaID) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.reload();
      try {
        final documento = await FirebaseFirestore.instance.collection('atividades').doc(listaID).get();

        documento.reference.delete();

        return 'Atividade excluída com sucesso.';
      } on FirebaseException catch (e) {
        if (e.code == 'path.isNotEmpty') {
          throw 'Atividade não encontrada.';
        } else {
          throw 'Ocorreu um erro ao excluir a atividade: $e';
        }
      } catch (e) {
        throw 'Ocorreu um erro ao excluir a atividade: $e';
      }
    } else {
      throw 'Usário Null';
    }
  }
}
