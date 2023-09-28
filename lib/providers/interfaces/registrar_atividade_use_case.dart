import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';

abstract class RegistrarAtividadeUseCase {
  Future<String> call(ModeloDeAtividade modeloDeAtividade);
}
