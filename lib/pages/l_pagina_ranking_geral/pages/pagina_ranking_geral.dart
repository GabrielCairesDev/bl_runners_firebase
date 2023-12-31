import 'package:bl_runners_app/pages/l_pagina_ranking_geral/components/pagina_ranking_geral_botao_filtro.dart';
import 'package:bl_runners_app/pages/l_pagina_ranking_geral/controller/pagina_ranking_geral_controlador.dart';
import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_app/widgets/lista_de_atividade/lista_de_atividade_widget.dart';
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
    final controladorPaginaRankingGeral =
        Provider.of<PaginaRankingGeralControlador>(context);
    final controladorPegarUsuarioAtual =
        Provider.of<PegarUsuarioAtual>(context);

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
          Visibility(
            visible: controladorPaginaRankingGeral.carregando == false,
            child: ListaDeAtividadeWidget(
              controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
              mostrarBotaoExlcuir: false,
              listasSomadas: true,
              carregarAtividades:
                  controladorPaginaRankingGeral.carregarAtividades,
              listaDeAtividades:
                  controladorPaginaRankingGeral.listaDeAtividades,
              listaDeUsuarios: controladorPaginaRankingGeral.listaDeUsuarios,
              anoFiltro: controladorPaginaRankingGeral.anoFiltro,
              mesFiltro: controladorPaginaRankingGeral.mesFiltro,
              idUsuario: '',
              paginaPerfil: false,
            ),
          ),
        ],
      ),
    );
  }
}
