import 'package:bl_runners_firebase/pages/10_pagina_ranking_geral/components/pagina_ranking_geral_botao_filtro.dart';
import 'package:bl_runners_firebase/pages/10_pagina_ranking_geral/controller/pagina_ranking_geral_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRankingGeral extends StatefulWidget {
  const PaginaRankingGeral({super.key});

  @override
  State<PaginaRankingGeral> createState() => _PaginaRankingGeralState();
}

class _PaginaRankingGeralState extends State<PaginaRankingGeral> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controlador = context.read<PaginaRankingGeralControlador>();
      if (controlador.carregadoInitState == false) {
        controlador.carregarAtividades();
        controlador.carregadoInitState = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controladorPaginaRankingGeral = Provider.of<PaginaRankingGeralControlador>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Ranking Geral'),
        actions: [
          PaginaRankingGeralBotaoFiltro(
            paginaRankingGeralControlador: controladorPaginaRankingGeral,
          )
        ],
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
          Positioned.fill(
            child: Visibility(
              visible: controladorPaginaRankingGeral.carregando,
              child: const Align(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          // PaginaInicioLista(controladorPaginaInicio: controladorPaginaInicial, controladorPegarUsuarioAtual: controladorPegarUsuarioAtual),
        ],
      ),
    );
  }
}
