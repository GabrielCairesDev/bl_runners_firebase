import 'package:bl_runners_firebase/pages/11_pagina_ranking_feminino/controller/pagina_ranking_feminino_controlador.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class PaginaRankingFemininoBotaoFiltro extends StatefulWidget {
  const PaginaRankingFemininoBotaoFiltro({super.key, required this.controladorPaginaRankingFeminino});

  final PaginaRankingFemininoControlador controladorPaginaRankingFeminino;

  @override
  State<PaginaRankingFemininoBotaoFiltro> createState() => _PaginaRankingFemininoBotaoFiltroState();
}

class _PaginaRankingFemininoBotaoFiltroState extends State<PaginaRankingFemininoBotaoFiltro> {
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
              widget.controladorPaginaRankingFeminino.anoFiltro = date.year;
              widget.controladorPaginaRankingFeminino.mesFiltro = date.month;
              widget.controladorPaginaRankingFeminino.carregarAtividades();
            },
          );
        }
      },
    );
  }
}
