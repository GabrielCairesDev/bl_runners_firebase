import 'package:bl_runners_firebase/errors/custom_exception.dart';
import 'package:bl_runners_firebase/providers/interfaces/recuperar_conta_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRecuperarConta extends RecuperarContaUseCase {
  @override
  Future<String> call({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'E-mail enviado para:\n$email';
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          throw CustomException(message: 'E-mail não encontrado. Verifique o email fornecido.');
        } else if (e.code == 'invalid-email') {
          throw CustomException(message: 'Email inválido. Verifique o e-mail.');
        } else {
          throw CustomException(message: 'Erro ao enviar email! $e');
        }
      } else {
        throw CustomException(message: 'Algo deu errado: $e');
      }
    }
  }
}
