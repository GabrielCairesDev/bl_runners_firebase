import 'dart:async';

import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginaInicioControlador extends ChangeNotifier {
  String ano = '2023';
  String mes = '9';

  final Map<String, ModeloDeAtividade> _atividades = {};

  List<ModeloDeAtividade> get listaAtividades => _atividades.values.toList();

  Future<String> pegarAtividades() async {
    try {
      final atividades = await FirebaseFirestore.instance.collection('atividades').get();

      for (var element in atividades.docs) {
        var atividade = ModeloDeAtividade.fromJson(element.data());
        _atividades[element.id] = atividade;
      }
      notifyListeners();
      return 'pegou';
    } catch (e) {
      throw 'Erro: $e';
    }
  }
}
