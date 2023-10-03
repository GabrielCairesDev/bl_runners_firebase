import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:flutter/material.dart';

class PaginaRegistrarCampoDescricao extends StatelessWidget {
  const PaginaRegistrarCampoDescricao({super.key, required this.controlador});

  final PaginaRegistrarAtividadeControlador controlador;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: Validador.descricao,
      controller: controlador.controladorCampoDescricao,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Descrição',
        filled: false,
      ),
      minLines: 4,
      maxLines: 4,
    );
  }
}
