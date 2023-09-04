import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaginaRegistrarCampoData extends StatefulWidget {
  const PaginaRegistrarCampoData({super.key});

  @override
  State<PaginaRegistrarCampoData> createState() => _PaginaRegistrarCampoDataState();
}

class _PaginaRegistrarCampoDataState extends State<PaginaRegistrarCampoData> {
  TextEditingController controlador = TextEditingController(text: 'Data');
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
          prefixIcon: const Icon(Icons.date_range),
          border: const OutlineInputBorder(),
          hintText: controlador.text,
          suffixIcon: const Icon(Icons.expand_more),
        ),
        onTap: () async => _selecionarDataHora(context),
      ),
    );
  }

  Future<void> _selecionarDataHora(context) async {
    DateTime? pegarData = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 3)),
        lastDate: DateTime.now(),
        helpText: 'Que dia você correu?',
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF2e355a),
                  onPrimary: Colors.white,
                  onSurface: Colors.blueGrey,
                ),
              ),
              child: child!);
        });

    if (pegarData != null) {
      TimeOfDay? pegarHora = await showTimePicker(
        context: context,
        helpText: 'Que horário você correu?',
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          // MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!);
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF2e355a),
                  onPrimary: Colors.white,
                  onSurface: Colors.blueGrey,
                ),
              ),
              child: child!);
        },
      );

      if (pegarHora != null) {
        DateTime dataHoraSelecionada = DateTime(
          pegarData.year,
          pegarData.month,
          pegarData.day,
          pegarHora.hour,
          pegarHora.minute,
        );
        String dataHoraFormatada = DateFormat('dd/MM/yyyy HH:mm').format(dataHoraSelecionada);

        setState(() {
          print('data e hora selecionadas: $dataHoraFormatada');
          controlador.text = dataHoraFormatada;
        });
      }
    }
  }
}
