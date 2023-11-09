import 'package:bl_runners_app/pages/i_pagina_admin/controller/pagina_admin_controlador.dart';
import 'package:flutter/material.dart';

class PaginaAdminPesquisar extends StatelessWidget {
  const PaginaAdminPesquisar({super.key, required this.controlador});

  final PaginaAdminControlador controlador;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.transparent,
        child: TextField(
          controller: controlador.controladorPesquisa,
          onChanged: controlador.filtrarLista,
          decoration: InputDecoration(
            labelText: 'Pesquisar por nome',
            hintText: 'Pesquisar',
            prefixIcon: const Icon(Icons.search),
            suffix: InkWell(
              onTap: () {
                controlador.controladorPesquisa.text = '';
                controlador.filtrarLista('');
              },
              child: const Icon(Icons.close),
            ),
          ),
        ),
      ),
    );
  }
}
