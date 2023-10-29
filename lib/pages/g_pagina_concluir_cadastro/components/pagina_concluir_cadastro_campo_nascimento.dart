import 'package:bl_runners_firebase/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controller/pagina_concluir_cadastro_controlador.dart';

class PaginaConcluirCampoNascimento extends StatefulWidget {
  const PaginaConcluirCampoNascimento({super.key, required this.controladorConcluirCadastro, required this.controladorPegarUsuario});

  final PaginaConcluirCadastroControlador controladorConcluirCadastro;
  final PegarUsuarioAtual controladorPegarUsuario;

  @override
  State<PaginaConcluirCampoNascimento> createState() => _PaginaConcluirCampoNascimentoState();
}

class _PaginaConcluirCampoNascimentoState extends State<PaginaConcluirCampoNascimento> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      validator: Validador.nascimento,
      controller: widget.controladorConcluirCadastro.controladorNascimento,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.calendar_month),
        filled: true,
        hintText: 'Data de nascimento',
      ),
      onTap: () async {
        DateTime? pegarData = await showDatePicker(
          context: context,
          initialDate: widget.controladorPegarUsuario.usuarioAtual!.dataNascimento.toDate(),
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
          helpText: 'Selecione a data de nascimento',
          initialDatePickerMode: DatePickerMode.year,
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
          DateTime dataHoraSelecionada = DateTime.utc(
            pegarData.year,
            pegarData.month,
            pegarData.day,
            14,
          );

          Timestamp pegarHoraTimeStamp = Timestamp.fromDate(dataHoraSelecionada);
          String dataFormatada = DateFormat('dd/MM/yyyy').format(dataHoraSelecionada);

          setState(() {
            widget.controladorConcluirCadastro.dataNascimento = pegarHoraTimeStamp;
            widget.controladorConcluirCadastro.controladorNascimento.text = dataFormatada;
          });
        }
      },
    );
  }
}
