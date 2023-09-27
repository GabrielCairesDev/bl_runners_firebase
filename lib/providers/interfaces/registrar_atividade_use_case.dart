import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';

abstract class RegistrarAtividadeUseCase {
  Future<bool> call(ModeloDeAtividade modeloDeAtividade);
}
