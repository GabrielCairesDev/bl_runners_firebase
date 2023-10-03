import 'package:bl_runners_firebase/extensions/data_formatada_exetension.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_botao_add.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaInicial = Provider.of<PaginaInicioControlador>(context);
    final controladorPegarUsuario = Provider.of<PegarUsuario>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: InkWell(
          onTap: () => controladorPaginaInicial.pegarAtividades(),
          child: const Text('Início'),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
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
                        child: Text('Lista ID: ${atividade.idUsuario}'),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: PaginaInicioBotaoAdd(
        controlador: controladorPegarUsuario,
      ),
    );
  }
}
