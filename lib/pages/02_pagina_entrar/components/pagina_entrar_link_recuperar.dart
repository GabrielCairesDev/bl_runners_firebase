import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaEntrarLinkRecuperar extends StatelessWidget {
  const PaginaEntrarLinkRecuperar({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaEntrar = Provider.of<PaginaEntrarControlador>(context);
    return InkWell(
      onTap: () => controladorPaginaEntrar.recuperarConta(context),
      child: const Text(
        'Recuperar conta',
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
