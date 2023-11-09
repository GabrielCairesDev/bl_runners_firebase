import 'package:bl_runners_app/main.dart';
import 'package:bl_runners_app/models/modelo_de_usuario.dart';
import 'package:bl_runners_app/providers/interfaces/editar_tag_admin_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/editar_tag_autorizado_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/editar_tag_master_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/pegar_todos_usuarios_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginaAdminControlador extends ChangeNotifier {
  PaginaAdminControlador({
    required this.pegarTodosUsuariosUseCase,
    required this.editarTagMasterUseCase,
    required this.editarTagAdminUseCase,
    required this.editarTagAutorizadoUseCase,
  });

  final PegarTodosUsuariosUseCase pegarTodosUsuariosUseCase;
  final EditarTagMasterUseCase editarTagMasterUseCase;
  final EditarTagAdminUseCase editarTagAdminUseCase;
  final EditarTagAutorizadoUseCase editarTagAutorizadoUseCase;

  bool carregando = false;
  bool carregadoInitState = false;

  late List<ModeloDeUsuario> listaDeUsuarios = [];
  late List<ModeloDeUsuario> listaDeUsuariosFiltro = [];

  final TextEditingController controladorPesquisa = TextEditingController();

  Future<void> carregarUsuarios() async {
    listaDeUsuarios.clear();
    listaDeUsuariosFiltro.clear();
    try {
      _atualizarEstadoCarregando();
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
        dataNascimento: Timestamp.now(),
      );

      final pegarUsuarios = await pegarTodosUsuariosUseCase(modeloDeUsuario);
      listaDeUsuarios = pegarUsuarios;

      listaDeUsuariosFiltro.addAll(listaDeUsuarios);

      logger.i('Lista com todos os usuários carregada!');
    } catch (e) {
      logger.w(e);
    } finally {
      _atualizarEstadoCarregando();
    }
  }

  void filtrarLista(String pesquisa) {
    listaDeUsuariosFiltro.clear();
    listaDeUsuariosFiltro.addAll(
      listaDeUsuarios.where(
        (usuario) => usuario.nome.toLowerCase().contains(
              pesquisa.toLowerCase(),
            ),
      ),
    );
    notifyListeners();
  }

  Future<String> editarMaster({
    required String listaUsuarioId,
    required String usuarioAtualId,
    required bool novoValor,
    required bool usuarioAtualMaster,
    required bool usuarioAtualAdmin,
    required bool usuarioAtualAutorizado,
    required bool listaUsuarioCadastroConcluido,
    required bool listaUsuarioAutorizado,
    required bool listaUsuarioAdmin,
  }) async {
    if (listaUsuarioId == usuarioAtualId) throw 'Você não pode fazer isso!';
    if (!usuarioAtualMaster || !usuarioAtualAdmin || !usuarioAtualAutorizado)
      throw 'Você não tem permissão!';
    if (!listaUsuarioAutorizado) throw 'Usuário não está autorizado';
    if (!listaUsuarioCadastroConcluido)
      throw 'Usuário não concluiu o cadastro!';
    if (!listaUsuarioAdmin) throw 'Usuário não é um administrador!';

    try {
      final resultado = await editarTagMasterUseCase(
          listaUsuarioId: listaUsuarioId, listaUsuarioMaster: novoValor);
      carregarUsuarios();

      return resultado;
    } catch (e) {
      rethrow;
    }
  }

  editarAdmin({
    required String listaUsuarioId,
    required String usuarioAtualId,
    required bool novoValor,
    required bool usuarioAtualMaster,
    required bool usuarioAtualAdmin,
    required bool usuarioAtualAutorizado,
    required bool listaUsuarioCadastroConcluido,
    required bool listaUsuarioAutorizado,
    required bool listaUsuarioMaster,
  }) async {
    if (listaUsuarioId == usuarioAtualId) throw 'Você não pode fazer isso!';
    if (!usuarioAtualMaster || !usuarioAtualAdmin || !usuarioAtualAutorizado)
      throw 'Você não tem permissão!';
    if (!listaUsuarioCadastroConcluido)
      throw 'Usuário não concluiu o cadastro!';
    if (!listaUsuarioAutorizado) throw 'Usuário não está autorizado!';
    if (listaUsuarioMaster) throw 'Você não pode fazer isso com um master!';

    try {
      final resultado = await editarTagAdminUseCase(
          listaUsuarioId: listaUsuarioId, listaUsuarioAdmin: novoValor);
      carregarUsuarios();

      return resultado;
    } catch (e) {
      rethrow;
    }
  }

  editarAutorizado({
    required String listaUsuarioId,
    required bool novoValor,
    required String usuarioAtualId,
    required bool usuarioAtualMaster,
    required bool usuarioAtualAdmin,
    required bool usuarioAtualAutorizado,
    required bool listaUsuarioAdmin,
    required bool listaUsuarioMaster,
    required bool listaUsuarioAutorizado,
  }) async {
    if (listaUsuarioId == usuarioAtualId) throw 'Você não pode fazer isso!';
    if (!usuarioAtualAdmin || !usuarioAtualAutorizado)
      throw 'Você não tem permissão!';
    if (listaUsuarioMaster && listaUsuarioAutorizado)
      throw 'Você não pode desautorizar Master!';
    if (listaUsuarioAdmin && listaUsuarioAutorizado)
      throw 'Você não pode desautorizar Administrador!';

    try {
      final resultado = await editarTagAutorizadoUseCase(
          listaUsuarioId: listaUsuarioId, listaUsuarioAutorizado: novoValor);
      carregarUsuarios();

      return resultado;
    } catch (e) {
      rethrow;
    }
  }

  _atualizarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
