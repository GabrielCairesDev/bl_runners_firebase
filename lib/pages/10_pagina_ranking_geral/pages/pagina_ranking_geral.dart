import 'package:flutter/material.dart';

class PaginaRankingGeral extends StatelessWidget {
  const PaginaRankingGeral({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Ranking Geral'),
        // actions: [
        //   PaginaInicioBotaoFiltro(
        //     controladorPaginaInicial: controladorPaginaInicial,
        //   )
        // ],
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              child: Icon(
                Icons.groups,
                size: 200,
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
          ),
          // Positioned.fill(
          //   child: Visibility(
          //     visible: controladorPaginaInicial.carregando,
          //     child: const Align(
          //       child: CircularProgressIndicator(),
          //     ),
          //   ),
          // ),
          // PaginaInicioLista(controladorPaginaInicio: controladorPaginaInicial, controladorPegarUsuarioAtual: controladorPegarUsuarioAtual),
        ],
      ),
    );
  }
}
