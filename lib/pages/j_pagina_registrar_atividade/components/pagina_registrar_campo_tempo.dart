import 'package:bl_runners_app/pages/j_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:intl/intl.dart';

class PaginaRegistrarCampoTempo extends StatefulWidget {
  const PaginaRegistrarCampoTempo({super.key, required this.controlador});

  final PaginaRegistrarAtividadeControlador controlador;

  @override
  State<PaginaRegistrarCampoTempo> createState() =>
      _PaginaRegistrarCampoTempoState();
}

class _PaginaRegistrarCampoTempoState extends State<PaginaRegistrarCampoTempo> {
  int horaPadrao = 0;
  int minutoPadrao = 0;
  int segundoPadrao = 0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      validator: (value) {
        if (value == null || widget.controlador.tempoSegundos == null) {
          return 'Campo Obrigatório';
        } else if (widget.controlador.tempoSegundos! < 1) {
          return 'Tempo Inválido';
        }
        return null;
      },
      controller: widget.controlador.controladorCampoTempo,
      decoration: const InputDecoration(
        filled: false,
        prefixIcon: Icon(Icons.timer),
        border: OutlineInputBorder(),
        hintText: 'Tempo',
        suffixIcon: Icon(Icons.expand_more),
      ),
      onTap: () async {
        await picker.DatePicker.showTimePicker(
          context,
          currentTime:
              DateTime(1, 1, 1, horaPadrao, minutoPadrao, segundoPadrao),
          showTitleActions: false,
          onChanged: (date) {
            setState(
              () {
                String tempoFormatado = DateFormat.Hms().format(date);
                widget.controlador.controladorCampoTempo.text = tempoFormatado;

                List<String> partesTempo = tempoFormatado.split(':');
                int horas = int.parse(partesTempo[0]);
                int minutos = int.parse(partesTempo[1]);
                int segundos = int.parse(partesTempo[2]);

                horaPadrao = horas;
                minutoPadrao = minutos;
                segundoPadrao = segundos;

                int totalSegundos = horas * 3600 + minutos * 60 + segundos;
                widget.controlador.tempoSegundos = totalSegundos;
              },
            );
          },
          theme: const picker.DatePickerTheme(
            itemStyle: TextStyle(color: Colors.blueGrey),
          ),
        );
      },
    );
  }
}
