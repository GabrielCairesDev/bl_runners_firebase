import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaEntrarBotaoEntrar extends StatelessWidget {
  const PaginaEntrarBotaoEntrar({super.key, required this.controlador});

  final PaginaEntrarControlador controlador;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _entrar(context),
        child: const Text('Entrar'),
      ),
    );
  }

  _entrar(BuildContext context) async {
    FocusScope.of(context).unfocus();
    await controlador.entrar().then((value) => _entrarSucesso(context, value)).catchError(
          (onError) => _entrarError(context, onError),
        );
  }

  _entrarSucesso(BuildContext context, value) {
    debugPrint('Entrou: $value');
    context.pushReplacement(Rotas.navegar);
    logger.d(value);
  }

  _entrarError(BuildContext context, onError) {
    Mensagens.mensagemErro(context, texto: onError);
    logger.e(onError);
  }
}
