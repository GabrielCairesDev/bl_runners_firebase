abstract class EditarTagAutorizadoUseCase {
  Future<String> call({
    required String listaUsuarioId,
    required bool listaUsuarioAutorizado,
  });
}
