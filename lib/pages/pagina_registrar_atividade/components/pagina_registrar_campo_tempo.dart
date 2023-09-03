import 'package:flutter/material.dart';

class PaginaRegistrarCampoTempo extends StatefulWidget {
  const PaginaRegistrarCampoTempo({super.key});

  @override
  State<PaginaRegistrarCampoTempo> createState() => _PaginaRegistrarCampoTempoState();
}

class _PaginaRegistrarCampoTempoState extends State<PaginaRegistrarCampoTempo> {
  TextEditingController controlador = TextEditingController(text: 'Tempo');
  @override
  Widget build(BuildContext context) {
    return Form(
      //    key: controlador.globalKeyCampoDistancia,
      child: TextFormField(
        readOnly: true,
        //   validator: controlador.validadorDistancia,
        controller: controlador,
        decoration: InputDecoration(
          filled: false,
          prefixIcon: const Icon(Icons.timer),
          border: const OutlineInputBorder(),
          hintText: controlador.text,
          suffixIcon: const Icon(Icons.expand_more),
        ),
        onTap: () async {
          TimeOfDay? pegarTempo = await showTimePicker(
            context: context,
            initialTime: const TimeOfDay(hour: 0, minute: 0),
            helpText: 'Tempo de atividade',
          );
          if (pegarTempo != null) {
            setState(() {
              controlador.text = pegarTempo.format(context);
            });
          }
        },
      ),
    );
  }
}
