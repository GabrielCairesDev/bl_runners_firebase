import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';

class PaginaRegistrarCampoTempo extends StatefulWidget {
  const PaginaRegistrarCampoTempo({super.key, required this.controlador});

  final PaginaRegistrarAtividadeControlador controlador;

  @override
  State<PaginaRegistrarCampoTempo> createState() => _PaginaRegistrarCampoTempoState();
}

class _PaginaRegistrarCampoTempoState extends State<PaginaRegistrarCampoTempo> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      validator: (value) {
        if (value == null || widget.controlador.tempo == null) {
          return 'Campo Obrigatório';
        } else if (widget.controlador.tempo!.minute < 1 && widget.controlador.tempo!.hour < 1) {
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
        widget.controlador.tempo = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 0, minute: 0),
          helpText: 'Qual foi duração?',
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color(0xFF2e355a),
                    onPrimary: Colors.white,
                    onSurface: Colors.blueGrey,
                  ),
                ),
                child: child!,
              ),
            );
          },
        );

        if (widget.controlador.tempo != null) {
          setState(() {
            widget.controlador.controladorCampoTempo.text = widget.controlador.tempo!.format(context);
            widget.controlador.transformarEmMinutos(tempo: widget.controlador.tempo as TimeOfDay);
          });
        }
      },
    );
  }
}
