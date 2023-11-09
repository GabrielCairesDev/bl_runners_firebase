import 'package:bl_runners_app/providers/interfaces/registrar_usuario_use_case.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';

class PaginaRegistrarUsuarioControlador extends ChangeNotifier {
  PaginaRegistrarUsuarioControlador({required this.registrarUsuarioUseCase});

  final RegistrarUsuarioUseCase registrarUsuarioUseCase;

  final TextEditingController controladorNome = TextEditingController();
  final TextEditingController controladorEmail = TextEditingController();
  final TextEditingController controladorSenha = TextEditingController();
  final TextEditingController controladorConfirmarSenha =
      TextEditingController();

  final GlobalKey<FormState> globalKeyPaginaRegistrar = GlobalKey<FormState>();

  bool carregando = false;
  bool termosAceito = false;

  Future<String> registrarUsuario() async {
    final internet = await Connectivity().checkConnectivity();

    if (internet == ConnectivityResult.none)
      throw 'Sem conexão com a internet!';
    if (!termosAceito) throw 'Aceite o termo de Uso e Política de Privacidade!';

    if (globalKeyPaginaRegistrar.currentState!.validate()) {
      try {
        _alterarEstadoCarregando();
        final resultado = await registrarUsuarioUseCase(
          email: controladorEmail.text.trim(),
          senha: controladorSenha.text.trim(),
          nome: controladorNome.text,
        );
        _resetarValores();
        return resultado;
      } catch (e) {
        rethrow;
      } finally {
        _alterarEstadoCarregando();
      }
    }
    throw 'Preencha todos os campos';
  }

  _resetarValores() {
    controladorNome.clear();
    controladorEmail.clear();
    controladorSenha.clear();
    controladorConfirmarSenha.clear();
  }

  _alterarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
