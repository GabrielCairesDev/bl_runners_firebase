import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarCampoBotao extends StatelessWidget {
  const PaginaRegistrarCampoBotao({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _registrarAtividade(context),
      icon: const Icon(Icons.save),
    );
  }

  _registrarAtividade(BuildContext context) {
    final controladorPaginaRegistrarAtividade = Provider.of<PaginaRegistrarAtividadeControlador>(context);
    controladorPaginaRegistrarAtividade.registrarAtividade().then((value) {
      if (value) {
        Mensagens.mensagemSucesso(context, texto: 'Atividade registrada com sucesso!');
        controladorPaginaRegistrarAtividade.alterarCarregando();
        FocusScope.of(context).unfocus();
        controladorPaginaRegistrarAtividade.resetarValores();
        context.pop();
      } else {
        Mensagens.mensagemErro(context, texto: 'Algo deu errado');
      }
    });
  }
}
