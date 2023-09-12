import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarCampoBotao extends StatelessWidget {
  const PaginaRegistrarCampoBotao({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaRegistrarAtividade = Provider.of<PaginaRegistrarAtividadeControlador>(context);
    return IconButton(
      onPressed: () => controladorPaginaRegistrarAtividade.validar(context),
      icon: const Icon(Icons.save),
    );
  }
}
