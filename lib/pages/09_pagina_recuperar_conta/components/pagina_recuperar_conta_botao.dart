import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/pages/09_pagina_recuperar_conta/controller/pagina_recuperar_conta_controlador.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaRecuperarContaBotao extends StatelessWidget {
  const PaginaRecuperarContaBotao({super.key, required this.controlador});

  final PaginaRecuperarContaControlador controlador;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _recuperarConta(context),
        child: const Text('Enviar'),
      ),
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
  Mensagens.mensagemErro(context, texto: onError.toString());
  logger.d(onError);
}
