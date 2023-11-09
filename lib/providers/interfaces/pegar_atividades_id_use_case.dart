import 'package:bl_runners_app/models/modelo_de_atividade.dart';

abstract class PegarAtividadesIdUsuarioUseCase {
  Future<List<ModeloDeAtividade>> call(ModeloDeAtividade modeloDeAtividade,
      {required String idUsuario});
}
