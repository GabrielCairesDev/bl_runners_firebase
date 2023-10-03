import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_usuario_use_case.dart';
import 'package:flutter/widgets.dart';

class PaginaRegistrarUsuarioControlador extends ChangeNotifier {
  final RegistrarUsuarioUseCase registrarUsuarioUseCase;

  PaginaRegistrarUsuarioControlador({required this.registrarUsuarioUseCase});

  final controladorNome = TextEditingController(text: 'Gabriel');
  final controladorEmail = TextEditingController();
  final controladorSenha = TextEditingController(text: 'gabriel');
  final controladorCnfirmarSenha = TextEditingController(text: 'gabriel');

  final GlobalKey<FormState> globalKeyPaginaRegistrar = GlobalKey<FormState>();

  bool carregando = false;

  Future<String> registrarUsuario() async {
    if (globalKeyPaginaRegistrar.currentState!.validate()) {
      final modeloDeUsuario = ModeloDeUsuario(
        id: '',
        nome: controladorNome.text,
        email: controladorEmail.text.trim(),
        fotoUrl: '',
        genero: 'Masculino',
        master: false,
        admin: false,
        autorizado: false,
        cadastroConcluido: false,
        dataNascimento: DateTime.now(),
      );

      try {
        alterarEstadoCarregando();
        final resultado = await registrarUsuarioUseCase(
          modeloDeUsuario,
          email: controladorEmail.text.trim(),
          senha: controladorSenha.text,
          nome: controladorNome.text,
        );
        resetarValores();
        return resultado;
      } catch (e) {
        rethrow;
      } finally {
        alterarEstadoCarregando();
      }
    }
    throw 'Preencha todos os campos';
  }

  resetarValores() {
    controladorNome.clear();
    controladorEmail.clear();
    controladorSenha.clear();
    controladorCnfirmarSenha.clear();
  }

  alterarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
