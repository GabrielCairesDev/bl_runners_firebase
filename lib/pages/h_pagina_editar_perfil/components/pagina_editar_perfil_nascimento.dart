import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_app/utils/validadores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfilNascimento extends StatefulWidget {
  const PaginaEditarPerfilNascimento(
      {super.key,
      required this.controladorEditarPerfil,
      required this.controladorPegarUsuario});

  final PaginaEditarPerfilControlador controladorEditarPerfil;
  final PegarUsuarioAtual controladorPegarUsuario;

  @override
  State<PaginaEditarPerfilNascimento> createState() =>
      _PaginaEditarPerfilNascimentoState();
}

class _PaginaEditarPerfilNascimentoState
    extends State<PaginaEditarPerfilNascimento> {
  @override
  void initState() {
    super.initState();
    widget.controladorEditarPerfil.controladorNascimento.text =
        DateFormat('dd/MM/yyyy').format(widget
                .controladorPegarUsuario.usuarioAtual?.dataNascimento
                .toDate() ??
            DateTime.now());
    widget.controladorEditarPerfil.dataNascimento =
        widget.controladorPegarUsuario.usuarioAtual?.dataNascimento ??
            Timestamp.now();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      validator: Validador.nascimento,
      controller: widget.controladorEditarPerfil.controladorNascimento,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.calendar_month),
        filled: true,
        hintText: 'Data de nascimento',
      ),
      onTap: () async {
        DateTime? pegarData = await showDatePicker(
          context: context,
          initialDate: widget
              .controladorPegarUsuario.usuarioAtual!.dataNascimento
              .toDate(),
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

          Timestamp pegarHoraTimeStamp =
              Timestamp.fromDate(dataHoraSelecionada);
          String dataFormatada =
              DateFormat('dd/MM/yyyy').format(dataHoraSelecionada);

          setState(() {
            widget.controladorEditarPerfil.dataNascimento = pegarHoraTimeStamp;
            widget.controladorEditarPerfil.controladorNascimento.text =
                dataFormatada;
          });
        }
      },
    );
  }
}
