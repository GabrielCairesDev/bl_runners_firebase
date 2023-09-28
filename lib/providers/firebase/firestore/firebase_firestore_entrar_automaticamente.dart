import 'package:bl_runners_firebase/providers/interfaces/entrar_automaticamente_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseFirestoreEntrarAutomaticamente extends EntrarAutomaticamenteUseCase {
  @override
  Future<String> call() async {
    User? user = FirebaseAuth.instance.currentUser;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool entradaAutomatica = prefs.getBool('entradaAutomatica') ?? false;

    if (user != null && entradaAutomatica == true && user.emailVerified == true) {
      return 'Entrou automaticamente';
    } else {
      throw 'Não entrou automaticamente';
    }
  }
}
