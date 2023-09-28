import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';

abstract class RegistrarUsuarioUseCase {
  Future<String> call(
    ModeloDeUsuario modeloDeUsuario, {
    required String email,
    required String senha,
    required String nome,
  });
}
