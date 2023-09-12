import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarCampoDescricao extends StatelessWidget {
  const PaginaRegistrarCampoDescricao({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaRegistrarAtividade = Provider.of<PaginaRegistrarAtividadeControlador>(context);
    return Form(
      key: controladorPaginaRegistrarAtividade.globalKeyCampoDescricao,
      child: TextFormField(
        validator: controladorPaginaRegistrarAtividade.validadorDescricao,
        controller: controladorPaginaRegistrarAtividade.controladorCampoDescricao,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Descrição',
          filled: false,
        ),
        minLines: 4,
        maxLines: 4,
      ),
    );
  }
}
