import 'package:bl_runners_firebase/providers/interfaces/entrar_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreEntrar extends EntrarUseCase {
  @override
  Future<bool> call({required String email, required String senha}) async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha);

      if (credential.user != null) {
        if (credential.user!.emailVerified == true) {
          // await prefs.setBool("entradaAutomatica", entradaAutomatica);
          return true;
        } else {
          // Quando o e-mail não é verificado
          // throw 'E-mail de verificação enviado para:\n${credential.user!.email';

          await credential.user!.sendEmailVerification();
          return false;
        }
      }

      // Erros
    } on FirebaseAuthException catch (e) {
      // Usuário não encontrado
      if (e.code == 'user-not-found') {
        //  throw 'E-mail não registrado!';
        return false;

        // Senha inválida
      } else if (e.code == 'wrong-password') {
        //    throw 'Senha inválida!';
        return false;

        // E-mail inválido
      } else if (e.code == 'invalid-email') {
        //  throw 'E-mail inválido!';
        return false;

        // Outro erro
      } else {
        //   throw 'Erro ao fazer login!';
        return false;
      }
    } catch (e) {
      // throw 'Erro ao fazer login! $e';
      return false;
    }
    return false;
  }
}
