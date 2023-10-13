import 'package:bl_runners_firebase/pages/11_pagina_ranking_feminino/components/pagina_ranking_feminino_botao_filtro.dart';
import 'package:bl_runners_firebase/pages/11_pagina_ranking_feminino/controller/pagina_ranking_feminino_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRankingFeminino extends StatefulWidget {
  const PaginaRankingFeminino({super.key});

  @override
  State<PaginaRankingFeminino> createState() => _PaginaRankingFemininoState();
}

class _PaginaRankingFemininoState extends State<PaginaRankingFeminino> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controlador = context.read<PaginaRankingFemininoControlador>();
      if (controlador.carregadoInitState == false) {
        controlador.carregarAtividades();
        controlador.carregadoInitState = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controladorPaginaRankingFeminino = Provider.of<PaginaRankingFemininoControlador>(context);
    final controladorPegarUsuarioAtual = Provider.of<PegarUsuarioAtual>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Ranking Feminino'),
        actions: [
          PaginaRankingFemininoBotaoFiltro(
            controladorPaginaRankingFeminino: controladorPaginaRankingFeminino,
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
              visible: controladorPaginaRankingFeminino.carregando,
              child: const Align(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          Visibility(
            visible: controladorPaginaRankingFeminino.carregando == false,
            child: ListaDeAtividadeWidget(
              controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
              mostrarBotaoExlcuir: false,
              listasSomadas: true,
              carregarAtividades: controladorPaginaRankingFeminino.carregarAtividades,
              listaDeAtividades: controladorPaginaRankingFeminino.listaDeAtividades,
              listaDeUsuarios: controladorPaginaRankingFeminino.listaDeUsuarios,
              anoFiltro: controladorPaginaRankingFeminino.anoFiltro,
              mesFiltro: controladorPaginaRankingFeminino.mesFiltro,
              idUsuario: '',
              paginaPerfil: false,
            ),
          ),
        ],
      ),
    );
  }
}
