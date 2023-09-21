import 'dart:async';

import 'package:bl_runners_firebase/models/mode_de_atividade.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginaInicioControlador extends ChangeNotifier {
  String ano = '2023';
  String mes = '9';

  final Map<String, ModeloDeUsuario> _usuarios = {};

  List<ModeloDeUsuario> get listaUsuarios => _usuarios.values.toList();
  List<ModeloDeAtividade> atividades = [];

  Future<void> pegarListaDocumentosID() async {
    List<String> listaDocumendosID = [];

    try {
      final colecao = FirebaseFirestore.instance.collection('usuarios');
      final documentos = await colecao.get();

      for (DocumentSnapshot snapShot in documentos.docs) {
        listaDocumendosID.add(snapShot.id);
      }

      for (String value in listaDocumendosID) {
        await inserirUsuarioNaListaUsuarios(idUsuario: value);
        await pegarListaUsuariosAtividades(id: value);
      }
    } catch (e) {
      debugPrint('Erro: $e');
    }
    notifyListeners();
  }

  Future<void> pegarListaUsuariosAtividades({required String id}) async {
    List<String> listaAtividades = [];
    try {
      final colecao = FirebaseFirestore.instance.collection('usuarios').doc(id).collection('atividades').doc(ano).collection(mes);
      final documentos = await colecao.get();

      for (DocumentSnapshot atividade in documentos.docs.toList()) {
        listaAtividades.add(atividade.id);
      }

      for (String value in listaAtividades) {
        await pegarAtividadeData(id: id, atividade: value);
      }
    } catch (e) {
      debugPrint('Erro: $e');
    }
  }

  Future<void> pegarAtividadeData({required String id, required String atividade}) async {
    final documento = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(id)
        .collection('atividades')
        .doc(ano)
        .collection(mes)
        .doc(atividade)
        .get();

    if (documento.exists) {
      final data = documento.data() as Map<String, dynamic>;
      final modelo = ModeloDeAtividade.fromJson(data);
      atividades.add(modelo);
      notifyListeners();
    } else {
      debugPrint('nada');
    }
  }

  Future<void> inserirUsuarioNaListaUsuarios({required String idUsuario}) async {
    final documento = await FirebaseFirestore.instance.collection('usuarios').doc(idUsuario).collection('perfil').doc('dados').get();

    if (documento.exists) {
      final dadosDoUsuario = documento.data() as Map<String, dynamic>;
      final modeloDeUsuario = ModeloDeUsuario.fromJson(dadosDoUsuario);

      _usuarios[modeloDeUsuario.id] = modeloDeUsuario;
      notifyListeners();
    } else {
      debugPrint('Documento não encontrado.');
    }
  }
}
