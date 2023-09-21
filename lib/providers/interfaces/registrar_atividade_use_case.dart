import 'package:bl_runners_firebase/models/mode_de_atividade.dart';

abstract class RegistrarAtividadeUseCase {
  Future<bool> call(ModeloDeAtividade modeloDeAtividade);
}
