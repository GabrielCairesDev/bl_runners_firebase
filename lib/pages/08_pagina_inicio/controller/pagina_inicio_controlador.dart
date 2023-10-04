import 'dart:async';

import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_use_case.dart';
import 'package:flutter/material.dart';

class PaginaInicioControlador extends ChangeNotifier {
  final PegarAtividadesUseCase pegarAtividadesUseCase;

  PaginaInicioControlador({required this.pegarAtividadesUseCase});

  int ano = DateTime.now().year;
  int mes = DateTime.now().month;

  late List<ModeloDeAtividade> listaAtividades = [];

  Future<void> pegarAtividades() async {
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

    try {
      final resultado = await pegarAtividadesUseCase(modeloDeAtividade, ano: ano, mes: mes, lista: listaAtividades);
      listaAtividades = resultado.cast<ModeloDeAtividade>();
      notifyListeners();
    } catch (e) {
      logger.d(e);
    }
  }
}

    // final atividades = await FirebaseFirestore.instance.collection('atividades').where('ano', isEqualTo: 2023).get();

    // for (var element in atividades.docs) {
    //   var atividade = ModeloDeAtividade.fromJson(element.data());
    //   _atividades[element.id] = atividade;
    //   notifyListeners();
    // }

