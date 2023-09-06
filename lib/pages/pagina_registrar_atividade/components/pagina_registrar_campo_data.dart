import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarCampoData extends StatefulWidget {
  const PaginaRegistrarCampoData({super.key});

  @override
  State<PaginaRegistrarCampoData> createState() => _PaginaRegistrarCampoDataState();
}

class _PaginaRegistrarCampoDataState extends State<PaginaRegistrarCampoData> {
  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaRegistrarAtividadeControlador>();
    return Form(
      key: controlador.globalKeyCampoData,
      child: TextFormField(
        readOnly: true,
        validator: controlador.validadorData,
        controller: controlador.controladorCampoData,
        decoration: const InputDecoration(
          filled: false,
          prefixIcon: Icon(Icons.date_range),
          border: OutlineInputBorder(),
          hintText: 'Data',
          suffixIcon: Icon(Icons.expand_more),
        ),
        onTap: () async {
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
                child: child!,
              );
            },
          );

          if (pegarData != null) {
            // ignore: use_build_context_synchronously
            TimeOfDay? pegarHora = await showTimePicker(
              context: context,
              helpText: 'Que horário você correu?',
              initialTime: TimeOfDay.now(),
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

            if (pegarHora != null) {
              DateTime dataHoraSelecionada = DateTime(
                pegarData.year,
                pegarData.month,
                pegarData.day,
                pegarHora.hour,
                pegarHora.minute,
              );
              String dataHoraFormatada = DateFormat('dd/MM/yyyy HH:mm').format(dataHoraSelecionada);
              setState(
                () {
                  controlador.controladorCampoData.text = dataHoraFormatada;
                },
              );
            }
          }
        },
      ),
    );
  }
}
