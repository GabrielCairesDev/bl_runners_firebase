import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_usuario_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreRegistrarUsuario extends RegistrarUsuarioUseCase {
  @override
  Future<bool> call(
    ModeloDeUsuario modeloDeUsuario, {
    required String email,
    required String nome,
    required String senha,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha);
      credential.user!.updateDisplayName(nome);
      credential.user!.sendEmailVerification();
      modeloDeUsuario = modeloDeUsuario.coyWith(
        admin: false,
        autorizado: false,
        cadastroConcluido: false,
        dataNascimento: DateTime.now(),
        email: '',
        fotoUrl: '',
        genero: 'Masculino',
        id: credential.user!.uid,
        master: false,
        nome: '',
      );
      FirebaseFirestore.instance.collection('usuarios').doc().set(modeloDeUsuario.toJson());
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        print('Este e-mail já está em uso.');
      } else {
        print('Erro durante o registro: ${e.message}');
      }
      return false;
    } catch (e) {
      print('Erro desconhecido: $e');
      return false;
    }
  }
}
