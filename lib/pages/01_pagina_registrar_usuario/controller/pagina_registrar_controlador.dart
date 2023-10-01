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

  bool esconderSenha = true;
  bool esconderSenha2 = true;
  bool carregando = false;

  String? validadorNome(String? value) {
    if (value!.isEmpty || value.length < 3) {
      return 'Campo obrigatório!';
    }
    return null;
  }

  String? validadorEmail(String? value) {
    final regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value!.isEmpty) {
      return 'Campo obrigatório!';
    } else if (!regExp.hasMatch(value)) {
      return 'E-mail invalido!';
    }
    return null;
  }

  String? validadorSenha(String? value) {
    if (value!.isEmpty) {
      return 'Campo obrigatório!';
    } else if (value.length < 6) {
      return 'Senha curta!';
    }
    return null;
  }

  String? validadorConfirmarSenha(String? value) {
    if (value!.isEmpty) {
      return 'Campo obrigatório!';
    } else if (value != controladorSenha.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

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
        atualizarCarregando();
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
        atualizarCarregando();
      }
    }
    throw 'Preencha todos os campos';
  }

  resetarValores() {
    controladorNome.clear();
    controladorEmail.clear();
    controladorSenha.clear();
    controladorCnfirmarSenha.clear();
    esconderSenha = true;
    esconderSenha2 = true;
  }

  atualizarCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
