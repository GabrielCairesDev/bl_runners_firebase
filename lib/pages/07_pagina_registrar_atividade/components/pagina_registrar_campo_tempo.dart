import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarCampoTempo extends StatefulWidget {
  const PaginaRegistrarCampoTempo({super.key});

  @override
  State<PaginaRegistrarCampoTempo> createState() => _PaginaRegistrarCampoTempoState();
}

class _PaginaRegistrarCampoTempoState extends State<PaginaRegistrarCampoTempo> {
  @override
  Widget build(BuildContext context) {
    final controladorPaginaRegistrarAtividade = Provider.of<PaginaRegistrarAtividadeControlador>(context);
    return TextFormField(
      readOnly: true,
      validator: controladorPaginaRegistrarAtividade.validadorTempo,
      controller: controladorPaginaRegistrarAtividade.controladorCampoTempo,
      decoration: const InputDecoration(
        filled: false,
        prefixIcon: Icon(Icons.timer),
        border: OutlineInputBorder(),
        hintText: 'Tempo',
        suffixIcon: Icon(Icons.expand_more),
      ),
      onTap: () async {
        controladorPaginaRegistrarAtividade.tempo = await showTimePicker(
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

        if (controladorPaginaRegistrarAtividade.tempo != null) {
          setState(() {
            controladorPaginaRegistrarAtividade.controladorCampoTempo.text = controladorPaginaRegistrarAtividade.tempo!.format(context);
            controladorPaginaRegistrarAtividade.transformarEmMinutos(tempo: controladorPaginaRegistrarAtividade.tempo as TimeOfDay);
          });
        }
      },
    );
  }
}
