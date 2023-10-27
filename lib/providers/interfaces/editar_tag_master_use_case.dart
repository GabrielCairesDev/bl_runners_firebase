abstract class EditarTagMasterUseCase {
  Future<String> call({
    required String listaUsuarioId,
    required bool listaUsuarioMaster,
  });
}
