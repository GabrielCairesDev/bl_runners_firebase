import 'package:bl_runners_app/models/modelo_de_usuario.dart';

abstract class PegarTodosUsuariosUseCase {
  Future<List<ModeloDeUsuario>> call(ModeloDeUsuario modeloDeUsuario);
}
