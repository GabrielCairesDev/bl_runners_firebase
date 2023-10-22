import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/excluir_atividade_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_id_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_usuarios_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/sair_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaPerfilControlador extends ChangeNotifier {
  PaginaPerfilControlador({
    required this.excluirAtividadeUseCase,
    required this.sairUseCase,
    required this.pegarAtividadesIdUsuarioUseCase,
    required this.pegarUsuariosUseCase,
  });

  final ExcluirAtividadeUseCase excluirAtividadeUseCase;
  final SairUseCase sairUseCase;
  final PegarUsuariosUseCase pegarUsuariosUseCase;
  final PegarAtividadesIdUsuarioUseCase pegarAtividadesIdUsuarioUseCase;

  late List<ModeloDeAtividade> listaDeAtividades = [];
  late List<ModeloDeUsuario> listaDeUsuarios = [];
  late List<ModeloDeAtividade> listaDeAtividadesSomadas = [];

  bool carregando = false;
  String idUsuario = '';

  Future<void> carregarAtividades() async {
    listaDeAtividades.clear();
    listaDeUsuarios.clear();
    listaDeAtividadesSomadas.clear();

    final modeloDeAtividade = ModeloDeAtividade(
      idAtividade: '',
      idUsuario: '',
      tipo: '',
      tempo: 0,
      distancia: 0,
      dataAtividade: Timestamp.now(),
      ano: 0,
      mes: 0,
    );

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

    try {
      alterarEstadoCarregando();

      final resultadoAtividades = await pegarAtividadesIdUsuarioUseCase(modeloDeAtividade, idUsuario: idUsuario);
      listaDeAtividades = resultadoAtividades;

      final resultadoUsuarios = await pegarUsuariosUseCase(modeloDeUsuario, listaDeAtividades);
      listaDeUsuarios = resultadoUsuarios;

      listaDeAtividades.sort((atividade1, atividade2) => atividade2.dataAtividade.compareTo(atividade1.dataAtividade));

      final listaDeAtividadesAgrupadasPorId = listaDeAtividades.groupListsBy((listaAtividades) => listaAtividades.idUsuario);

      final atividadesSomadas = listaDeAtividadesAgrupadasPorId.values.map(
        (atividadesDoUsuario) {
          return atividadesDoUsuario.first;
        },
      ).toList();

      for (final u in listaDeUsuarios) {
        int distanciaTotal = 0;
        int tempoTotal = 0;

        for (final a in listaDeAtividades.where((element) => element.idUsuario == u.id)) {
          distanciaTotal += a.distancia;
          tempoTotal += a.tempo;
        }

        var atividadeUsuario = atividadesSomadas.firstWhere(
          (atividade) => atividade.idUsuario == u.id,
          orElse: () => ModeloDeAtividade(
            idUsuario: u.id,
            ano: 0,
            dataAtividade: Timestamp.now(),
            idAtividade: '',
            mes: 0,
            tipo: '',
            distancia: 0,
            tempo: 0,
          ),
        );

        var atualizarAtividade = ModeloDeAtividade(
          idUsuario: atividadeUsuario.idUsuario,
          distancia: distanciaTotal,
          tempo: tempoTotal,
          ano: 0,
          dataAtividade: Timestamp.now(),
          idAtividade: '',
          mes: 0,
          tipo: '',
        );

        if (atividadesSomadas.contains(atividadeUsuario)) {
          atividadesSomadas[atividadesSomadas.indexOf(atividadeUsuario)] = atualizarAtividade;
        } else {
          atividadesSomadas.add(atualizarAtividade);
        }
      }
      listaDeAtividadesSomadas = atividadesSomadas.toList();
    } catch (e) {
      logger.e(e);
    } finally {
      notifyListeners();
      alterarEstadoCarregando();
    }
  }

  Future<String> excluirAtividade({required String listaID, required String? idUsuario}) async {
    final internet = await Connectivity().checkConnectivity();

    if (internet == ConnectivityResult.none) throw 'Sem conexão com a internet!';
    if (idUsuario == null || idUsuario.isEmpty) throw 'Usuário vázio ou Null!';

    try {
      final resultado = await excluirAtividadeUseCase(listaID);
      carregarAtividades();
      return resultado;
    } catch (e) {
      rethrow;
    } finally {
      print('fim');
    }
  }

  Future<String> sair() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final resultado = await sairUseCase();
      prefs.setBool("entrarAutomaticamente", false);
      return resultado;
    } catch (e) {
      throw 'Erro ao tentar sair: $e!';
    }
  }

  alterarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
