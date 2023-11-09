import 'package:bl_runners_app/providers/interfaces/excluir_conta_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseExcluirConta extends ExcluirContaUseCase {
  @override
  Future<String> call({required String senha}) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await currentUser.reload();
      try {
        final AuthCredential credential = EmailAuthProvider.credential(
            email: currentUser.email!, password: senha);
        await currentUser.reauthenticateWithCredential(credential);

        final atividades = await FirebaseFirestore.instance
            .collection('atividades')
            .where('idUsuario', isEqualTo: currentUser.uid)
            .get();

        for (final atividade in atividades.docs) {
          await atividade.reference.delete();
        }
        FirebaseFirestore.instance
            .collection('usuarios')
            .doc(currentUser.uid)
            .delete();
        FirebaseStorage.instance
            .ref()
            .child("usuarios_foto_perfil/${currentUser.uid}")
            .delete();

        await currentUser.delete();

        return 'Conta excluída com sucesso!';
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          throw 'Senha inválida!';
        } else {
          throw 'Erro ao excluir conta!\n${e.message}';
        }
      } on FirebaseException catch (e) {
        throw 'Erro ao excluir conta!\n${e.message}';
      } catch (e) {
        throw 'Erro ao excluir conta!\n$e';
      }
    } else {
      throw 'Usuário não encontrado!';
    }
  }
}
