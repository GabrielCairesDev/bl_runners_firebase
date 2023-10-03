import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ConcluirCadastroUseCase {
  Future<String> call(ModeloDeUsuario modeloDeUsuario, User usuarioAtual);
}
