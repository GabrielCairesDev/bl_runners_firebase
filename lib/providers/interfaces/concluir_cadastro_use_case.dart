import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';

abstract class ConcluirCadastroUseCase {
  Future<String> call(
    ModeloDeUsuario modeloDeUsuario, {
    required imagemArquivo,
    required String nome,
    required String genero,
    required DateTime nascimento,
  });
}
