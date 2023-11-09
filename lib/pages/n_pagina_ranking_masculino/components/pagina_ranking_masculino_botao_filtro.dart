import 'package:bl_runners_app/pages/n_pagina_ranking_masculino/controller/pagina_ranking_masculino_controlador.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class PaginaRankingMasculinoBotaoFiltro extends StatefulWidget {
  const PaginaRankingMasculinoBotaoFiltro(
      {super.key, required this.controladorPaginaRankingMasculino});

  final PaginaRankingMasculinoControlador controladorPaginaRankingMasculino;

  @override
  State<PaginaRankingMasculinoBotaoFiltro> createState() =>
      _PaginaRankingMasculinoBotaoFiltroState();
}

class _PaginaRankingMasculinoBotaoFiltroState
    extends State<PaginaRankingMasculinoBotaoFiltro> {
  DateTime? _dataSelecionada = DateTime.now();
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
      initialDate: _dataSelecionada,
      headerColor: const Color(0xFF2e355a),
      unselectedMonthTextColor: const Color(0xFF2e355a),
      selectedMonthBackgroundColor: const Color(0xFFc1d22b),
      dismissible: true,
    ).then(
      (date) {
        if (date != null) {
          setState(
            () {
              _dataSelecionada = date;
              widget.controladorPaginaRankingMasculino.anoFiltro = date.year;
              widget.controladorPaginaRankingMasculino.mesFiltro = date.month;
              widget.controladorPaginaRankingMasculino.carregarAtividades();
            },
          );
        }
      },
    );
  }
}
