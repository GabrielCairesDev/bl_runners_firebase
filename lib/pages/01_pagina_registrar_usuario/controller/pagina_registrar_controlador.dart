import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_usuario_use_case.dart';
import 'package:flutter/widgets.dart';

class PaginaRegistrarUsuarioControlador extends ChangeNotifier {
  PaginaRegistrarUsuarioControlador({required this.registrarUsuarioUseCase});

  final RegistrarUsuarioUseCase registrarUsuarioUseCase;

  final TextEditingController controladorNome = TextEditingController();
  final TextEditingController controladorEmail = TextEditingController();
  final TextEditingController controladorSenha = TextEditingController();
  final TextEditingController controladorConfirmarSenha = TextEditingController();

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
          senha: controladorSenha.text.trim(),
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
    controladorConfirmarSenha.clear();
  }

  alterarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
