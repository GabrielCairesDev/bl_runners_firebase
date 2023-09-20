import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginaInicioControlador extends ChangeNotifier {
  String ano = '2023';
  String mes = '9';

  List<String> listaDocumendosID = [];
  List<String> listaAtividadesAnos = [];

  Future<void> pegarListaDocumentosID() async {
    try {
      final colecao = FirebaseFirestore.instance.collection('usuarios');
      final documentosID = await colecao.get();

      listaDocumendosID.clear();

      for (DocumentSnapshot snapShot in documentosID.docs) {
        listaDocumendosID.add(snapShot.id);
      }

      notifyListeners();

      for (String id in listaDocumendosID) {
        await pegarAtividadesAnos(id);
      }
    } catch (e) {
      debugPrint('Erro: $e');
    }
  }

  Future<void> pegarAtividadesAnos(String id) async {
    try {
      final colecao =
          FirebaseFirestore.instance.collection('usuarios').doc(id.toString()).collection('atividades').doc(ano).collection(mes);
      final atividades = await colecao.get();
      List<String> lista = [];

      for (DocumentSnapshot snapshot in atividades.docs) {
        lista.add(snapshot.id);
        debugPrint('id: $id / dados: ${snapshot.id}');
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Erro: $e');
    }
  }
}
