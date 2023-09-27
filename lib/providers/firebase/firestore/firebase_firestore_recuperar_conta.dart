import 'package:bl_runners_firebase/errors/custom_error.dart';
import 'package:bl_runners_firebase/providers/interfaces/recuperar_conta_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreRecuperarConta extends RecuperarContaUseCase {
  @override
  Future<String> call({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'E-mail enviado para:\n$email';
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          throw CustomError(message: 'E-mail não encontrado. Verifique o email fornecido.');
        } else if (e.code == 'invalid-email') {
          throw CustomError(message: 'Email inválido. Verifique o e-mail.');
        } else {
          throw CustomError(message: 'Erro ao enviar email! $e');
        }
      } else {
        throw CustomError(message: 'Algo deu errado: $e');
      }
    }
  }
}
