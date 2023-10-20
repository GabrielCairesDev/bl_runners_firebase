import 'package:bl_runners_firebase/pages/k_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class PaginaInicioBotaoFiltro extends StatefulWidget {
  const PaginaInicioBotaoFiltro({super.key, required this.controladorPaginaInicial});

  final PaginaInicioControlador controladorPaginaInicial;

  @override
  State<PaginaInicioBotaoFiltro> createState() => _PaginaInicioBotaoFiltroState();
}

class _PaginaInicioBotaoFiltroState extends State<PaginaInicioBotaoFiltro> {
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
              widget.controladorPaginaInicial.anoFiltro = date.year;
              widget.controladorPaginaInicial.mesFiltro = date.month;
              widget.controladorPaginaInicial.carregarAtividades();
            },
          );
        }
      },
    );
  }
}
