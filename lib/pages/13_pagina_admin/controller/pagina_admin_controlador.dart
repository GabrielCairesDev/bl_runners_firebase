import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_todos_usuarios_use_case.dart';
import 'package:flutter/material.dart';

class PaginaAdminControlador extends ChangeNotifier {
  PaginaAdminControlador({required this.pegarTodosUsuariosUseCase});

  final PegarTodosUsuariosUseCase pegarTodosUsuariosUseCase;

  bool carregando = false;
  bool carregadoInitState = false;

  late List<ModeloDeUsuario> listaDeUsuarios = [];
  late List<ModeloDeUsuario> listaDeUsuariosFiltro = [];

  final controladorPesquisa = TextEditingController();

  Future<void> carregarUsuarios() async {
    listaDeUsuarios.clear();
    listaDeUsuariosFiltro.clear();
    try {
      final modeloDeUsuario = ModeloDeUsuario(
        id: '',
        nome: '',
        email: '',
        fotoUrl: '',
        genero: 'Masculino',
        master: false,
        admin: false,
        autorizado: false,
        cadastroConcluido: false,
        dataNascimento: DateTime.now(),
      );

      final pegarUsuarios = await pegarTodosUsuariosUseCase(modeloDeUsuario);
      listaDeUsuarios = pegarUsuarios;

      listaDeUsuariosFiltro.addAll(listaDeUsuarios);

      logger.i('Lista com todos os usuários carregada!');
    } catch (e) {
      logger.w(e);
    } finally {
      notifyListeners();
    }
  }

  void filtrarLista(String pesquisa) {
    listaDeUsuariosFiltro.clear();
    listaDeUsuariosFiltro.addAll(listaDeUsuarios.where((usuario) => usuario.nome.toLowerCase().contains(pesquisa.toLowerCase())));
    notifyListeners();
  }
}
