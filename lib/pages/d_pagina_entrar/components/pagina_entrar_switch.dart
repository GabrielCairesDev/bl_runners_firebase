import 'package:bl_runners_firebase/pages/d_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:flutter/material.dart';

class PaginaEntrarSwitch extends StatefulWidget {
  const PaginaEntrarSwitch({super.key, required this.controlador});

  final PaginaEntrarControlador controlador;

  @override
  State<PaginaEntrarSwitch> createState() => _PaginaEntrarSwitch();
}

class _PaginaEntrarSwitch extends State<PaginaEntrarSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: widget.controlador.entrarAutomaticamente,
          activeColor: const Color(0xFFc1d22b),
          onChanged: (bool value) =>
              setState(() => widget.controlador.entrarAutomaticamente = !widget.controlador.entrarAutomaticamente),
        ),
        const Text('Entrar automaticamente')
      ],
    );
  }
}
