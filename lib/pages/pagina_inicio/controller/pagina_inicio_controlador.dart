import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginaInicioControlador extends ChangeNotifier {
  Future<void> listaDocumentos() async {
    try {
      CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');
      QuerySnapshot documentos = await usuarios.get();
      print(documentos);

      for (var doc in documentos.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print(data);
      }
    } catch (e) {
      print('erro: $e');
    }
  }
}
