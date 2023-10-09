import 'dart:async';

import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/excluir_atividade_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_mes_ano_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_usuarios_use_case.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class PaginaInicioControlador extends ChangeNotifier {
  PaginaInicioControlador({
    required this.pegarAtividadesUseCase,
    required this.pegarUsuariosUseCase,
    required this.excluirAtividadeUseCase,
  });

  final PegarAtividadesMesAnoUseCase pegarAtividadesUseCase;
  final PegarUsuariosUseCase pegarUsuariosUseCase;
  final ExcluirAtividadeUseCase excluirAtividadeUseCase;

  bool carregando = false;
  bool carregadoInitState = false;

  int ano = DateTime.now().year;
  int mes = DateTime.now().month;

  late List<ModeloDeAtividade> listaAtividades = [];
  late List<ModeloDeUsuario> listaUsuarios = [];

  Future<void> carregarAtividades() async {
    listaAtividades.clear();
    listaUsuarios.clear();

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

      final resultadoAtividades = await pegarAtividadesUseCase(modeloDeAtividade, ano, mes);
      listaAtividades = resultadoAtividades;

      final resultadoUsuarios = await pegarUsuariosUseCase(modeloDeUsuario, listaAtividades);
      listaUsuarios = resultadoUsuarios;
    } catch (e) {
      logger.d(e);
    } finally {
      notifyListeners();
      atualizarEstadoCarregando();
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
      print('fin');
    }
  }

  atualizarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }

  String calcularRitmo(int? metros, int? minutos) {
    if (metros == null || metros == 0 || minutos == null || minutos == 0) {
      return '00:00/km';
    }

    double quilometros = metros / 1000.0;
    double ritmoMinutos = minutos / quilometros;

    if (ritmoMinutos.isInfinite || ritmoMinutos.isNaN) {
      return '00:00/km';
    }

    int minutosInteiros = ritmoMinutos.toInt();
    int segundosInteiros = ((ritmoMinutos - minutosInteiros) * 60).toInt();

    String resultado = '${minutosInteiros.toString().padLeft(2, '0')}:${segundosInteiros.toString().padLeft(2, '0')} /km';
    return resultado;
  }

  String formatarTempo(int? minutos) {
    if (minutos == null) {
      return '0h 0min';
    } else {
      int horas = minutos ~/ 60;
      int minutosRestantes = minutos % 60;
      return '${horas}h ${minutosRestantes}min';
    }
  }
}
