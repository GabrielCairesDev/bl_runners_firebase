abstract class RegistrarUsuarioUseCase {
  Future<String> call({
    required String email,
    required String senha,
    required String nome,
  });
}
