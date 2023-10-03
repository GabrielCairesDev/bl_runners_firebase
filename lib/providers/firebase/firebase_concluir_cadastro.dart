import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/concluir_cadastro_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseConcluirCadastro extends ConcluirCadastroUseCase {
  @override
  Future<String> call(ModeloDeUsuario modeloDeUsuario, User usuarioAtual) async {
    try {
      final documento = await FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid).get();

      if (!documento.exists) FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid).set({});

      await FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid).update(modeloDeUsuario.toJson());

      return 'Cadastro concluído com sucesso!';
    } catch (onError) {
      throw 'Erro ao concluir cadastro:\n$onError';
    }
  }
}
