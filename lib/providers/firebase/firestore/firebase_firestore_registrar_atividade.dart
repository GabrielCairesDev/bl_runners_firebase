import 'package:bl_runners_firebase/models/mode_de_atividade.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreRegistrarAtividade extends RegistrarAtividadeUseCase {
  @override
  Future<bool> call(ModeloDeAtividade modeloDeAtividade) async {
    final usuarioAtual = FirebaseAuth.instance.currentUser;
    if (usuarioAtual != null) {
      modeloDeAtividade = modeloDeAtividade.copyWith(idUsuario: usuarioAtual.uid);
      await FirebaseFirestore.instance.collection('atividades').doc().set(modeloDeAtividade.toJson());
      return true;
    } else {
      return false;
    }
  }
}
