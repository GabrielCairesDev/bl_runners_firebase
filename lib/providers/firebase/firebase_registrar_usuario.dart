import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_usuario_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRegistrarUsuario extends RegistrarUsuarioUseCase {
  @override
  Future<String> call({
    required String email,
    required String senha,
    required String nome,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha);
      credential.user!.updateDisplayName(nome);
      credential.user!.sendEmailVerification();

      final modeloDeUsuario = ModeloDeUsuario(
        admin: false,
        autorizado: false,
        cadastroConcluido: false,
        dataNascimento: Timestamp.now(),
        email: credential.user?.email ?? 'Erro ao registrar',
        fotoUrl: '',
        genero: 'Masculino',
        id: credential.user!.uid,
        master: false,
        nome: nome,
      );

      FirebaseFirestore.instance.collection('usuarios').doc(credential.user!.uid).set(modeloDeUsuario.toJson());
      return 'Conta criada com sucesso!\nVerifique o seu e-mail.';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'A senha é muito fraca!';
      } else if (e.code == 'email-already-in-use') {
        throw 'O e-mail já está em uso!';
      } else {
        throw 'Erro ao registrar: ${e.message}';
      }
    } catch (e) {
      throw 'Erro desconhecido: $e';
    }
  }
}
