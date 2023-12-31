import 'package:bl_runners_app/providers/interfaces/sair_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSair extends SairUseCase {
  @override
  Future<String> call() async {
    await FirebaseAuth.instance.signOut();
    return 'Saiu';
  }
}
