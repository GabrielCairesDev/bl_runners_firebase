import 'package:bl_runners_firebase/pages/12_pagina_ranking_masculino/components/pagina_ranking_masculino_botao_filtro.dart';
import 'package:bl_runners_firebase/pages/12_pagina_ranking_masculino/controller/pagina_ranking_masculino_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRankingMasculino extends StatefulWidget {
  const PaginaRankingMasculino({super.key});

  @override
  State<PaginaRankingMasculino> createState() => _PaginaRankingMasculinoState();
}

class _PaginaRankingMasculinoState extends State<PaginaRankingMasculino> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controlador = context.read<PaginaRankingMasculinoControlador>();
      if (controlador.carregadoInitState == false) {
        controlador.carregarAtividades();
        controlador.carregadoInitState = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controladorPaginaRankingMasculino = Provider.of<PaginaRankingMasculinoControlador>(context);
    final controladorPegarUsuarioAtual = Provider.of<PegarUsuarioAtual>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Ranking Feminino'),
        actions: [
          PaginaRankingMasculinoBotaoFiltro(
            controladorPaginaRankingMasculino: controladorPaginaRankingMasculino,
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              child: Icon(
                Icons.female,
                size: 200,
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: controladorPaginaRankingMasculino.carregando,
              child: const Align(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          ListaDeAtividadeWidget(
            controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
            paginaInicio: false,
            ranking: true,
            carregarAtividades: controladorPaginaRankingMasculino.carregarAtividades,
            listaDeAtividades: controladorPaginaRankingMasculino.listaDeAtividades,
            listaDeUsuarios: controladorPaginaRankingMasculino.listaDeUsuarios,
            anoFiltro: controladorPaginaRankingMasculino.anoFiltro,
            mesFiltro: controladorPaginaRankingMasculino.mesFiltro,
          ),
        ],
      ),
    );
  }
}
