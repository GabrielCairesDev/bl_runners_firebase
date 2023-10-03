import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:flutter/material.dart';

class PaginaRegistrarCampoTitulo extends StatelessWidget {
  const PaginaRegistrarCampoTitulo({super.key, required this.controlador});

  final PaginaRegistrarAtividadeControlador controlador;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: Validador.titulo,
      controller: controlador.controladorCampoTitulo,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Título',
        filled: false,
      ),
    );
  }
}
