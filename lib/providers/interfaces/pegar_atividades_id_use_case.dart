import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';

abstract class PegarAtividadesIdUsuarioUseCase {
  Future<List<ModeloDeAtividade>> call(ModeloDeAtividade modeloDeAtividade, String idUsuario);
}
