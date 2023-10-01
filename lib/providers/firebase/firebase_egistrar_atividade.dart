import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRegistrarAtividade extends RegistrarAtividadeUseCase {
  @override
  Future<String> call(ModeloDeAtividade modeloDeAtividade) async {
    final usuarioAtual = FirebaseAuth.instance.currentUser;
    if (usuarioAtual != null) {
      modeloDeAtividade = modeloDeAtividade.copyWith(idUsuario: usuarioAtual.uid);
      await FirebaseFirestore.instance.collection('atividades').doc().set(modeloDeAtividade.toJson());
      return 'Atividade registrada com sucesso!';
    } else {
      throw 'Erro ao registrar atividade!';
    }
  }
}
