import 'package:bl_runners_firebase/providers/interfaces/entrar_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreEntrar extends EntrarUseCase {
  @override
  Future<String> call({required String email, required String senha}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha);

      if (!credential.user!.emailVerified) {
        credential.user!.sendEmailVerification();
        throw 'E-mail de verificação enviado para:\n${email.toString()}';
      }

      return 'Login efetuado! ${credential.user!.email.toString()} | ${credential.user!.uid.toString()}';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw 'E-mail não registrado!';
        case 'wrong-password':
          throw 'Senha inválida!';
        case 'invalid-email':
          throw 'E-mail inválido!';
        default:
          throw 'Erro ao fazer login!\n ${e.message}';
      }
    }
  }
}
