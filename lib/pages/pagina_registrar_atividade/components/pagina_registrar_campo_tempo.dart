import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
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
    final controlador = context.read<PaginaRegistrarAtividadeControlador>();
    return Form(
      key: controlador.globalKeyCampoTempo,
      child: TextFormField(
        readOnly: true,
        validator: controlador.validadorTempo,
        controller: controlador.controladorCampoTempo,
        decoration: const InputDecoration(
          filled: false,
          prefixIcon: Icon(Icons.timer),
          border: OutlineInputBorder(),
          hintText: 'Tempo',
          suffixIcon: Icon(Icons.expand_more),
        ),
        onTap: () async {
          controlador.tempo = await showTimePicker(
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

          if (controlador.tempo != null) {
            setState(() => controlador.controladorCampoTempo.text = controlador.tempo!.format(context));
          }
        },
      ),
    );
  }
}
