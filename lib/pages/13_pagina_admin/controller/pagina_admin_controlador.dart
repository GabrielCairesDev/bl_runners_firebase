import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/editar_tag_admin_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/editar_tag_autorizado_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/editar_tag_master_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_todos_usuarios_use_case.dart';
import 'package:flutter/material.dart';

class PaginaAdminControlador extends ChangeNotifier {
  PaginaAdminControlador(
      {required this.pegarTodosUsuariosUseCase,
      required this.editarTagMasterUseCase,
      required this.editarTagAdminUseCase,
      required this.editarTagAutorizadoUseCase});

  final PegarTodosUsuariosUseCase pegarTodosUsuariosUseCase;
  final EditarTagMasterUseCase editarTagMasterUseCase;
  final EditarTagAdminUseCase editarTagAdminUseCase;
  final EditarTagAutorizadoUseCase editarTagAutorizadoUseCase;

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

  Future<String> editarMaster({
    required String idUsuario,
    required bool novoValor,
    required String idUsuarioAtual,
    required bool masterUsuarioAtual,
    required bool adminUsuarioAtual,
    required bool autorizadoUsuarioAtual,
  }) async {
    if (idUsuario == idUsuarioAtual) throw 'Você não pode fazer isso!';
    if (!masterUsuarioAtual || !adminUsuarioAtual || !autorizadoUsuarioAtual) throw 'Você não tem permissão!';

    try {
      final resultado = await editarTagMasterUseCase(
        idUsuario: idUsuario,
        master: novoValor,
      );
      return resultado;
    } catch (e) {
      rethrow;
    }
  }

  editarAdmin({
    required String idUsuario,
    required bool novoValor,
    required String idUsuarioAtual,
    required bool masterUsuarioAtual,
    required bool adminUsuarioAtual,
    required bool autorizadoUsuarioAtual,
  }) async {
    if (idUsuario == idUsuarioAtual) throw 'Você não pode fazer isso!';
    if (!masterUsuarioAtual || !adminUsuarioAtual || !autorizadoUsuarioAtual) throw 'Você não tem permissão!';

    try {
      final resultado = await editarTagAdminUseCase(
        idUsuario: idUsuario,
        admin: novoValor,
      );

      return resultado;
    } catch (e) {
      rethrow;
    }
  }

  editarAutorizado({
    required String idUsuario,
    required bool novoValor,
    required String idUsuarioAtual,
    required bool masterUsuarioAtual,
    required bool adminUsuarioAtual,
    required bool autorizadoUsuarioAtual,
  }) async {
    if (idUsuario == idUsuarioAtual) throw 'Você não pode fazer isso!';
    if (!adminUsuarioAtual || !autorizadoUsuarioAtual) throw 'Você não tem permissão!';

    try {
      final resultado = await editarTagAutorizadoUseCase(
        idUsuario: idUsuario,
        autorizado: novoValor,
      );

      return resultado;
    } catch (e) {
      rethrow;
    }
  }
}
