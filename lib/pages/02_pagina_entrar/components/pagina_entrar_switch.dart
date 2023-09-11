import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaEntrarSwitch extends StatefulWidget {
  const PaginaEntrarSwitch({super.key});

  @override
  State<PaginaEntrarSwitch> createState() => _PaginaEntrarSwitch();
}

class _PaginaEntrarSwitch extends State<PaginaEntrarSwitch> {
  @override
  Widget build(BuildContext context) {
    final controladorPaginaEntrar = context.read<PaginaEntrarControlador>();
    return Row(
      children: [
        Switch(
          value: controladorPaginaEntrar.entradaAutomatica,
          activeColor: const Color(0xFFc1d22b),
          onChanged: (bool value) => setState(
            () => controladorPaginaEntrar.entradaAutomatica = !controladorPaginaEntrar.entradaAutomatica,
          ),
        ),
        const Text('Entrar automática')
      ],
    );
  }
}
