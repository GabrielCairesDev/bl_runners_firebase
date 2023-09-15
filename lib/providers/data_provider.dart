import 'package:bl_runners_firebase/models/mode_de_atividade.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DataProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ModeloDeUsuario? modeloUsuario;

  // Metodo para pegar usuário Data
  Future<void> pegarUsuarioData() async {
    // Pegar usuário atual
    final user = FirebaseAuth.instance.currentUser;

    // Verificar se é nulo
    if (user != null) {
      // Pegar o documento com os dados
      final userData = _firestore.collection('usuarios').doc(user.uid).collection('perfil').doc('dados').snapshots();

      // Organizar os dados
      userData.listen(
        (snapshot) {
          if (snapshot.exists) {
            final data = snapshot.data() as Map<String, dynamic>;
            modeloUsuario = ModeloDeUsuario.fromJson(data);
            notifyListeners();
          } else {
            modeloUsuario = null;
          }
        },
      );
    } else {
      modeloUsuario = null;
    }
  }

  Future<void> registrarAtividade(BuildContext context) async {
    final controladorPaginaRegistrarAtividade = Provider.of<PaginaRegistrarAtividadeControlador>(context, listen: false);
    controladorPaginaRegistrarAtividade.alterarCarregando();
    // Pegar usuário
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final modeloDeAtividade = ModeloDeAtividade(
        id: user.uid,
        titulo: controladorPaginaRegistrarAtividade.controladorCampoTitulo.text,
        descricao: controladorPaginaRegistrarAtividade.controladorCampoDescricao.text,
        tipo: controladorPaginaRegistrarAtividade.controladorCampoTipo.text,
        tempo: controladorPaginaRegistrarAtividade.tempoMinutos as int,
        distancia: controladorPaginaRegistrarAtividade.controladorDistancia,
        dataAtividade: controladorPaginaRegistrarAtividade.dataHoraSelecionada as DateTime,
      );

      final documento = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('atividades')
          .doc(controladorPaginaRegistrarAtividade.dataHoraSelecionada!.year.toString())
          .collection(controladorPaginaRegistrarAtividade.dataHoraSelecionada!.month.toString())
          .doc(controladorPaginaRegistrarAtividade.dataHoraFormatadaSalvar.toString())
          .get();
      if (documento.exists) {
        if (context.mounted) {
          _mensagemErro(context, texto: 'Atividade já registrada!\nVerifique a data e horário.');
          controladorPaginaRegistrarAtividade.alterarCarregando();
          FocusScope.of(context).unfocus();
        }
      } else {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid.toString())
            .collection('atividades')
            .doc(controladorPaginaRegistrarAtividade.dataHoraSelecionada!.year.toString())
            .collection(controladorPaginaRegistrarAtividade.dataHoraSelecionada!.month.toString())
            .doc(controladorPaginaRegistrarAtividade.dataHoraFormatadaSalvar.toString())
            .set(modeloDeAtividade.toJson());
        if (context.mounted) {
          _mensagemSucesso(context, texto: 'Atividade registrada com sucesso!');
          controladorPaginaRegistrarAtividade.alterarCarregando();
          FocusScope.of(context).unfocus();
          // controladorPaginaRegistrarAtividade.resetarValores();
        }
      }
    } else {
      _mensagemErro(context, texto: 'Algo deu errado');
    }
  }

  // Mensagem erro
  Future<void> _mensagemErro(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: texto,
      ),
    );
  }

  // Mensagem sucesso
  Future<void> _mensagemSucesso(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: texto,
      ),
    );
  }
}
