import 'package:bl_runners_app/models/modelo_de_atividade.dart';

abstract class PegarAtividadesMesAnoUseCase {
  Future<List<ModeloDeAtividade>> call(
      ModeloDeAtividade modeloDeAtividade, int ano, int mes);
}
