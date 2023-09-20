import 'package:bl_runners_firebase/models/mode_de_atividade.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FirebaseFiresotreRegistrarAtividade extends ChangeNotifier {
  Future<void> registrarAtividade(BuildContext context) async {
    final controladorPaginaRegistrarAtividade = Provider.of<PaginaRegistrarAtividadeControlador>(context, listen: false);

    controladorPaginaRegistrarAtividade.alterarCarregando();

    final usuarioAtual = FirebaseAuth.instance.currentUser;

    if (usuarioAtual != null) {
      final modeloDeAtividade = ModeloDeAtividade(
        id: usuarioAtual.uid,
        titulo: controladorPaginaRegistrarAtividade.controladorCampoTitulo.text,
        descricao: controladorPaginaRegistrarAtividade.controladorCampoDescricao.text,
        tipo: controladorPaginaRegistrarAtividade.controladorCampoTipo.text,
        tempo: controladorPaginaRegistrarAtividade.tempoMinutos as int,
        distancia: controladorPaginaRegistrarAtividade.controladorDistancia,
        dataAtividade: controladorPaginaRegistrarAtividade.dataHoraSelecionada as DateTime,
      );

      final documentoFirebase = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuarioAtual.uid.toString())
          .collection('atividades')
          .doc(controladorPaginaRegistrarAtividade.dataHoraSelecionada!.year.toString())
          .get();

      if (documentoFirebase.exists == false) await documentoFirebase.reference.set({});

      final atividadeFireBase = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(usuarioAtual.uid)
          .collection('atividades')
          .doc(controladorPaginaRegistrarAtividade.dataHoraSelecionada!.year.toString())
          .collection(controladorPaginaRegistrarAtividade.dataHoraSelecionada!.month.toString())
          .doc(controladorPaginaRegistrarAtividade.dataHoraFormatadaSalvar.toString())
          .get();
      if (atividadeFireBase.exists) {
        if (context.mounted) {
          Mensagens.mensagemErro(context, texto: 'Atividade já registrada!');
          controladorPaginaRegistrarAtividade.alterarCarregando();
          FocusScope.of(context).unfocus();
        }
      } else {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(usuarioAtual.uid.toString())
            .collection('atividades')
            .doc(controladorPaginaRegistrarAtividade.dataHoraSelecionada!.year.toString())
            .collection(controladorPaginaRegistrarAtividade.dataHoraSelecionada!.month.toString())
            .doc(controladorPaginaRegistrarAtividade.dataHoraFormatadaSalvar.toString())
            .set(modeloDeAtividade.toJson());
        if (context.mounted) {
          Mensagens.mensagemSucesso(context, texto: 'Atividade registrada com sucesso!');
          controladorPaginaRegistrarAtividade.alterarCarregando();
          FocusScope.of(context).unfocus();
          controladorPaginaRegistrarAtividade.resetarValores();
          context.pop();
        }
      }
    } else {
      Mensagens.mensagemErro(context, texto: 'Algo deu errado');
    }
  }
}
