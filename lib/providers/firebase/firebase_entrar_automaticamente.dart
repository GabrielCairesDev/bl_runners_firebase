import 'package:bl_runners_app/providers/interfaces/entrar_automaticamente_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseEntrarAutomaticamente extends EntrarAutomaticamenteUseCase {
  @override
  Future<String> call({required bool entrarAutomaticamente}) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.reload();

      try {
        if (currentUser.isAnonymous) throw 'Crendenciais invalidas!';
        if (!currentUser.emailVerified) throw 'O e-mail não está verificado!';
        if (entrarAutomaticamente == false)
          throw 'Entrar automaticamente está desativado!';

        return 'Entrou automaticamente!';
      } catch (e) {
        throw 'Não entrou automaticamente: $e';
      }
    } else {
      throw 'Usuário Null!';
    }
  }
}
