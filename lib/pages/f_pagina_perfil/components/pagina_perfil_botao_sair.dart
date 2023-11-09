import 'package:bl_runners_app/main.dart';
import 'package:bl_runners_app/pages/f_pagina_perfil/controller/pagina_perfil_controlador.dart';
import 'package:bl_runners_app/routes/rotas.dart';
import 'package:bl_runners_app/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaPerfilBotaoSair extends StatelessWidget {
  const PaginaPerfilBotaoSair({super.key, required this.controlador});

  final PaginaPerfilControlador controlador;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _sair(context),
      icon: const Icon(Icons.exit_to_app),
    );
  }

  _sair(BuildContext context) async {
    await controlador
        .sair()
        .then(
          (value) => _sairSucesso(context, value),
        )
        .catchError(
          (onError) => _sairErro(context, onError),
        );
  }

  _sairSucesso(BuildContext context, value) {
    context.pushReplacement(Rotas.entrar);
    logger.d(value);
  }

  _sairErro(BuildContext context, onError) {
    Mensagens.mensagemErro(context, texto: onError);
    logger.e(onError);
  }
}
