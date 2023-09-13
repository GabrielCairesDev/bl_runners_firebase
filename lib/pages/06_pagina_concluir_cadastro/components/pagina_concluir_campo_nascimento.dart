import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_concluir_controlador.dart';

class PaginaConcluirCampoNascimento extends StatefulWidget {
  const PaginaConcluirCampoNascimento({super.key});

  @override
  State<PaginaConcluirCampoNascimento> createState() => _PaginaConcluirCampoNascimentoState();
}

class _PaginaConcluirCampoNascimentoState extends State<PaginaConcluirCampoNascimento> {
  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaConcluirControlador>();
    return TextFormField(
      controller: controlador.controladorNascimento,
      validator: controlador.validadorNascimento,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.calendar_month),
        filled: true,
        hintText: 'Data de nascimento',
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pegarData = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
          locale: const Locale("pt", "BR"),
        );

        if (pegarData != null) {
          String dataFormatada = DateFormat('dd/MM/yyyy').format(pegarData);
          setState(() {
            controlador.nascimentoData = pegarData;
            controlador.controladorNascimento.text = dataFormatada;
          });
        }
      },
    );
  }
}
