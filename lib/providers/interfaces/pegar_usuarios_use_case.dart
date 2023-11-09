import 'package:bl_runners_app/models/modelo_de_atividade.dart';
import 'package:bl_runners_app/models/modelo_de_usuario.dart';

abstract class PegarUsuariosUseCase {
  Future<List<ModeloDeUsuario>> call(ModeloDeUsuario modeloDeUsuario,
      List<ModeloDeAtividade> listaDeAtividades);
}
