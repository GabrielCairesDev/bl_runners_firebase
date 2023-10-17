import 'dart:async';

import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_mes_ano_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_usuarios_use_case.dart';
import 'package:flutter/material.dart';

class PaginaInicioControlador extends ChangeNotifier {
  PaginaInicioControlador({
    required this.pegarAtividadesUseCase,
    required this.pegarUsuariosUseCase,
  });

  final PegarAtividadesMesAnoUseCase pegarAtividadesUseCase;
  final PegarUsuariosUseCase pegarUsuariosUseCase;

  bool carregando = false;
  bool carregadoInitState = false;

  int anoFiltro = DateTime.now().year;
  int mesFiltro = DateTime.now().month;

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

      final resultadoAtividades = await pegarAtividadesUseCase(modeloDeAtividade, anoFiltro, mesFiltro);

      listaAtividades = resultadoAtividades;

      final resultadoUsuarios = await pegarUsuariosUseCase(modeloDeUsuario, listaAtividades);

      listaUsuarios = resultadoUsuarios;

      listaAtividades.sort((atividade1, atividade2) => atividade2.dataAtividade.compareTo(atividade1.dataAtividade));
      logger.i('Lista de atividades carregadas! Data: $mesFiltro/$anoFiltro.');
    } catch (e) {
      logger.w(e);
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
