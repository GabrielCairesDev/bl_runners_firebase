abstract class EditarTagAdminUseCase {
  Future<String> call({
    required String idUsuario,
    required bool admin,
  });
}
