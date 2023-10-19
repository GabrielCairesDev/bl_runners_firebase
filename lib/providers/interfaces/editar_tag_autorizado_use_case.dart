abstract class EditarTagAutorizadoUseCase {
  Future<String> call({
    required String idUsuario,
    required bool autorizado,
  });
}
