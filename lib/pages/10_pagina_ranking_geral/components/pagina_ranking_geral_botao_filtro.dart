import 'package:bl_runners_firebase/pages/10_pagina_ranking_geral/controller/pagina_ranking_geral_controlador.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class PaginaRankingGeralBotaoFiltro extends StatefulWidget {
  const PaginaRankingGeralBotaoFiltro({super.key, required this.paginaRankingGeralControlador});

  final PaginaRankingGeralControlador paginaRankingGeralControlador;

  @override
  State<PaginaRankingGeralBotaoFiltro> createState() => _PaginaRankingGeralBotaoFiltroState();
}

class _PaginaRankingGeralBotaoFiltroState extends State<PaginaRankingGeralBotaoFiltro> {
  DateTime? dataSelecionada = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _abrirCalendario(context),
      icon: const Icon(Icons.filter_list),
    );
  }

  _abrirCalendario(BuildContext context) async {
    showMonthPicker(
      context: context,
      initialDate: dataSelecionada,
      headerColor: const Color(0xFF2e355a),
      unselectedMonthTextColor: const Color(0xFF2e355a),
      selectedMonthBackgroundColor: const Color(0xFFc1d22b),
      dismissible: true,
    ).then(
      (date) {
        if (date != null) {
          setState(
            () {
              dataSelecionada = date;
              widget.paginaRankingGeralControlador.ano = date.year;
              widget.paginaRankingGeralControlador.mes = date.month;
              widget.paginaRankingGeralControlador.carregarAtividades();
            },
          );
        }
      },
    );
  }
}
