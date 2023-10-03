import 'package:bl_runners_firebase/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';

class PaginaEntrarLinkRecuperar extends StatelessWidget {
  const PaginaEntrarLinkRecuperar({super.key, required this.controlador});

  final PaginaEntrarControlador controlador;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _caixaEmail(context),
      child: const Text(
        'Recuperar conta',
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  _caixaEmail(BuildContext context) {
    Mensagens.caixaDialogoDigitarEmail(
      context,
      email: controlador.controladorEmailRecuperar,
      titulo: 'Digite o seu e-mail',
      textoBotaocancelar: 'Cancelar',
      textoBotaoEnviar: 'Enviar',
      onPressedCancelar: () => context.pop(),
      onPressedEnviar: () => _recuperarConta(context),
    );
  }

  _recuperarConta(BuildContext context) async {
    await controlador
        .recuperarConta()
        .then((value) => _recuperarContaSucesso(context, value))
        .catchError((onError) => _recuperarContaError(context, onError));
  }
}

_recuperarContaSucesso(BuildContext context, value) {
  context.pop();
  Mensagens.mensagemSucesso(context, texto: value);
  logger.d(value);
}

_recuperarContaError(BuildContext context, onError) {
  context.pop();
  Mensagens.mensagemErro(context, texto: onError.toString());
  logger.d(onError);
}
