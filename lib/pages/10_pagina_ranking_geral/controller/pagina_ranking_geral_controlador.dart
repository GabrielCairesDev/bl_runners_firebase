import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_mes_ano_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_usuarios_use_case.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class PaginaRankingGeralControlador extends ChangeNotifier {
  PaginaRankingGeralControlador({
    required this.pegarAtividadesUseCase,
    required this.pegarUsuariosUseCase,
  });

  final PegarAtividadesMesAnoUseCase pegarAtividadesUseCase;
  final PegarUsuariosUseCase pegarUsuariosUseCase;

  bool carregando = false;
  bool carregadoInitState = false;

  int anoFiltro = DateTime.now().year;
  int mesFiltro = DateTime.now().month;

  late List<ModeloDeAtividade> listaDeAtividades = [];
  late List<ModeloDeUsuario> listaDeUsuarios = [];

  Future<void> carregarAtividades() async {
    listaDeAtividades.clear();
    listaDeUsuarios.clear();

    final modeloDeAtividade = ModeloDeAtividade(
      idAtividade: '',
      idUsuario: '',
      tipo: '',
      tempo: 0,
      distancia: 0,
      dataAtividade: DateTime.now(),
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
      dataNascimento: DateTime.now(),
    );

    try {
      atualizarEstadoCarregando();

      final resultadoAtividades = await pegarAtividadesUseCase(modeloDeAtividade, anoFiltro, mesFiltro);
      listaDeAtividades = resultadoAtividades;

      final resultadoUsuarios = await pegarUsuariosUseCase(modeloDeUsuario, listaDeAtividades);
      listaDeUsuarios = resultadoUsuarios;

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
            dataAtividade: DateTime.now(),
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
          dataAtividade: DateTime.now(),
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

      listaDeAtividades = atividadesSomadas.toList();
      listaDeAtividades.sort((a, b) => b.distancia.compareTo(a.distancia.toInt()));
    } catch (e) {
      logger.d(e);
    } finally {
      notifyListeners();
      atualizarEstadoCarregando();
    }
  }

  atualizarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
