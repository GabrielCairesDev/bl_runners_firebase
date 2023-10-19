abstract class EditarTagMasterUseCase {
  Future<String> call({
    required String idUsuario,
    required bool master,
  });
}
