import 'package:bl_runners_firebase/providers/interfaces/excluir_conta_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseExcluirConta extends ExcluirContaUseCase {
  @override
  Future<String> call({required String senha}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: senha);
        await user.reauthenticateWithCredential(credential);
        await user.delete();

        FirebaseFirestore.instance.collection('usuarios').doc(user.uid).delete();
        FirebaseStorage.instance.ref().child("perfil_fotos/${user.uid}").delete();

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
