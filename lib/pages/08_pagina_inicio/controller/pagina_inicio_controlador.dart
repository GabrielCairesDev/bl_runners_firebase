import 'dart:async';

import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_usuarios_use_case.dart';
import 'package:flutter/material.dart';

class PaginaInicioControlador extends ChangeNotifier {
  final PegarAtividadesUseCase pegarAtividadesUseCase;
  final PegarUsuariosUseCase pegarUsuariosUseCase;

  PaginaInicioControlador({required this.pegarAtividadesUseCase, required this.pegarUsuariosUseCase});

  bool carregando = false;
  bool carregadoInitState = false;

  int ano = DateTime.now().year;
  int mes = DateTime.now().month;

  late List<ModeloDeAtividade> listaAtividades = [];
  late List<ModeloDeUsuario> listaUsuarios = [];

  Future<void> carregarAtividades() async {
    listaAtividades.clear();
    atualizarEstadoCarregando();

    final modeloDeAtividade = ModeloDeAtividade(
      idUsuario: '',
      titulo: '',
      descricao: '',
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

  atualizarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
