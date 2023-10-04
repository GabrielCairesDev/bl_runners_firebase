import 'package:bl_runners_firebase/extensions/data_formatada_exetension.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:flutter/material.dart';

class PaginaInicioLista extends StatelessWidget {
  const PaginaInicioLista({super.key, required this.controladorPaginaInicial});

  final PaginaInicioControlador controladorPaginaInicial;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controladorPaginaInicial.listaAtividades.length,
      itemBuilder: (context, index) {
        final atividade = controladorPaginaInicial.listaAtividades[index];

        DateTime data = atividade.dataAtividade;
        String dataFormatada = data.dataFormatada;

        // ATIVIDADES
        return Padding(
          padding: const EdgeInsets.only(right: 6, left: 8, top: 8),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              // FUNDO AZUL DE ACORDO COM O GENERO
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 0),
                      blurRadius: 5,
                    )
                  ],
                ),
                // DATA DE PUBLICAÇÃO
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 2),
                  child: Text(
                    dataFormatada.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  // FUNDO BRANCO //
                  Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 0),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Text('Lista ID: ${atividade.idUsuario}'),
                        Text('Ano: ${atividade.ano}'),
                        Text('Mes: ${atividade.mes}'),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
