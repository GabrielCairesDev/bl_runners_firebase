import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/pagina_concluir_cadastro_controlador.dart';

class PaginaConcluirCampoNascimento extends StatefulWidget {
  const PaginaConcluirCampoNascimento({super.key, required this.controladorConcluirCadastro});

  final PaginaConcluirCadastroControlador controladorConcluirCadastro;

  @override
  State<PaginaConcluirCampoNascimento> createState() => _PaginaConcluirCampoNascimentoState();
}

class _PaginaConcluirCampoNascimentoState extends State<PaginaConcluirCampoNascimento> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controladorConcluirCadastro.controladorNascimento,
      validator: Validador.nascimento,
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
          initialDatePickerMode: DatePickerMode.year,
        );

        if (pegarData != null) {
          String dataFormatada = DateFormat('dd/MM/yyyy').format(pegarData);
          setState(() {
            widget.controladorConcluirCadastro.nascimentoData = pegarData;
            widget.controladorConcluirCadastro.controladorNascimento.text = dataFormatada;
          });
        }
      },
    );
  }
}
