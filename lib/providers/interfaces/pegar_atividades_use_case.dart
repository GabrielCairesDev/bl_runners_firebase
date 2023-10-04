import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';

abstract class PegarAtividadesUseCase {
  Future<List> call(
    ModeloDeAtividade modeloDeAtividade, {
    required int ano,
    required int mes,
    required lista,
  });
}
