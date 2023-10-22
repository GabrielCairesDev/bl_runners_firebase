import 'package:bl_runners_firebase/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfilNascimento extends StatefulWidget {
  const PaginaEditarPerfilNascimento({super.key, required this.controladorEditarPerfil, required this.controladorPegarUsuario});

  final PaginaEditarPerfilControlador controladorEditarPerfil;
  final PegarUsuarioAtual controladorPegarUsuario;

  @override
  State<PaginaEditarPerfilNascimento> createState() => _PaginaEditarPerfilNascimentoState();
}

class _PaginaEditarPerfilNascimentoState extends State<PaginaEditarPerfilNascimento> {
  @override
  void initState() {
    super.initState();
    widget.controladorEditarPerfil.controladorNascimento.text =
        DateFormat('dd/MM/yyyy').format(widget.controladorPegarUsuario.usuarioAtual?.dataNascimento.toDate() ?? DateTime.now());
    widget.controladorEditarPerfil.dataNascimento =
        widget.controladorPegarUsuario.usuarioAtual?.dataNascimento ?? Timestamp.now();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controladorEditarPerfil.controladorNascimento,
      validator: Validador.nascimento,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.calendar_month),
        filled: true,
        hintText: 'Data de nascimento',
        labelText: 'Data de nascimento',
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pegarData = await showDatePicker(
          context: context,
          initialDate: widget.controladorPegarUsuario.usuarioAtual!.dataNascimento.toDate(),
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
          locale: const Locale("pt", "BR"),
          initialDatePickerMode: DatePickerMode.year,
        );

        if (pegarData != null) {
          DateTime dataComHora = pegarData.add(const Duration(hours: 11, minutes: 40));
          Timestamp dataTimestamp = Timestamp.fromDate(dataComHora.toUtc());
          String dataFormatada = DateFormat('dd/MM/yyyy').format(pegarData);
          setState(() {
            widget.controladorEditarPerfil.dataNascimento = dataTimestamp;
            widget.controladorEditarPerfil.controladorNascimento.text = dataFormatada;
          });
        }
      },
    );
  }
}
