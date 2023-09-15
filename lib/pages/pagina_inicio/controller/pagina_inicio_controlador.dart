import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginaInicioControlador extends ChangeNotifier {
  Future<void> listaDocumentos() async {
    try {
      final colecoes = FirebaseFirestore.instance.collection('usuarios');
      final documentos = await colecoes.get();

      for (DocumentSnapshot documento in documentos.docs) {
        print('Nome do documento: ${documento.id}');
      }
    } catch (e) {
      print('erro: $e');
    }
  }
}
