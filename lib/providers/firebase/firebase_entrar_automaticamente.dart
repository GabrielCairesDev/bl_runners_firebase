import 'package:bl_runners_firebase/providers/interfaces/entrar_automaticamente_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseEntrarAutomaticamente extends EntrarAutomaticamenteUseCase {
  @override
  Future<String> call({required bool entrarAutomaticamente}) async {
    User? usuarioAtual = FirebaseAuth.instance.currentUser;

    try {
      await usuarioAtual?.reload();

      if (usuarioAtual == null) throw 'Usuário Null!';
      if (usuarioAtual.isAnonymous) throw 'Crendenciais invalidas!';
      if (entrarAutomaticamente == false) throw 'Entrar automaticamente está desativado!';
      if (!usuarioAtual.emailVerified) throw 'O e-mail não está verificado!';

      return 'Entrou automaticamente!';
    } catch (e) {
      throw 'Não entrou automaticamente: $e';
    }
  }
}
