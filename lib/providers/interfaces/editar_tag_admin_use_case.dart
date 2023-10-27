abstract class EditarTagAdminUseCase {
  Future<String> call({
    required String listaUsuarioId,
    required bool listaUsuarioAdmin,
  });
}
