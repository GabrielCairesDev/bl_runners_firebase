import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarCampoTitulo extends StatelessWidget {
  const PaginaRegistrarCampoTitulo({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaRegistrarAtividade = Provider.of<PaginaRegistrarAtividadeControlador>(context);
    return Form(
      key: controladorPaginaRegistrarAtividade.globalKeyCampoTitulo,
      child: TextFormField(
        validator: controladorPaginaRegistrarAtividade.validadorTitulo,
        controller: controladorPaginaRegistrarAtividade.controladorCampoTitulo,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Título',
          filled: false,
        ),
      ),
    );
  }
}
