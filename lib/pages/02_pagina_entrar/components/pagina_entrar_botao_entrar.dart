import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaEntrarBotaoEntrar extends StatelessWidget {
  const PaginaEntrarBotaoEntrar({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaEntrar = context.read<PaginaEntrarControlador>();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controladorPaginaEntrar.validarCampos(context),
        child: const Text('Entrar'),
      ),
    );
  }
}
