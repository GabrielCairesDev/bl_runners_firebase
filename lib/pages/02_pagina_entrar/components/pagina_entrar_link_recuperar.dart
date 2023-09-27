// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';

class PaginaEntrarLinkRecuperar extends StatelessWidget {
  const PaginaEntrarLinkRecuperar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _recuperarConta(context),
      child: const Text(
        'Recuperar conta',
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  _recuperarConta(BuildContext context) {
    final controladorPaginaEntrar = context.read<PaginaEntrarControlador>();

    Mensagens.caixaDialogoDigitarEmail(
      context,
      email: controladorPaginaEntrar.controladorEmailRecuperar,
      titulo: 'Digite o seu e-mail',
      textoBotaocancelar: 'Cancelar',
      textoBotaoEnviar: 'Enviar',
      onPressedCancelar: () {
        FocusScope.of(context).unfocus();
        context.pop();
      },
      onPressedEnviar: () async {
        controladorPaginaEntrar.recuperarConta().then((value) {
          Mensagens.mensagemSucesso(context, texto: value);
          context.pop();
          controladorPaginaEntrar.resetarValores();
          controladorPaginaEntrar.atualizarEstadoCarregando();
        }).catchError(
          (error) {
            Mensagens.mensagemErro(context, texto: error.toString());
            context.pop();
            controladorPaginaEntrar.resetarValores();
            controladorPaginaEntrar.atualizarEstadoCarregando();
          },
        );
      },
    );
  }
}
