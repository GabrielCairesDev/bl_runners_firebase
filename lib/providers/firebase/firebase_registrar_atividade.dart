import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirebaseRegistrarAtividade extends RegistrarAtividadeUseCase {
  @override
  Future<String> call(ModeloDeAtividade modeloDeAtividade) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.reload();

      var idAtividade = const Uuid().v4();
      final documento = await FirebaseFirestore.instance.collection('atividades').doc(idAtividade).get();
      if (documento.exists) throw 'Tente novamente!';

      try {
        modeloDeAtividade = modeloDeAtividade.copyWith(idUsuario: currentUser.uid, idAtividade: idAtividade);
        await FirebaseFirestore.instance.collection('atividades').doc(idAtividade).set(modeloDeAtividade.toJson());
        return 'Atividade registrada com sucesso!';
      } catch (e) {
        throw 'Erro ao registrar atividade!';
      }
    } else {
      throw 'Usuário Null';
    }
  }
}
