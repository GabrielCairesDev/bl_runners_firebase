import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';

abstract class PegarTodosUsuariosUseCase {
  Future<List<ModeloDeUsuario>> call(ModeloDeUsuario modeloDeUsuario);
}
