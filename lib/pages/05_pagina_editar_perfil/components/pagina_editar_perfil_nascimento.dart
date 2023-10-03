import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario.dart';
import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfilNascimento extends StatefulWidget {
  const PaginaEditarPerfilNascimento({super.key, required this.controladorEditarPerfil, required this.controladorPegarUsuario});

  final PaginaEditarPerfilControlador controladorEditarPerfil;
  final PegarUsuario controladorPegarUsuario;

  @override
  State<PaginaEditarPerfilNascimento> createState() => _PaginaEditarPerfilNascimentoState();
}

class _PaginaEditarPerfilNascimentoState extends State<PaginaEditarPerfilNascimento> {
  @override
  void initState() {
    super.initState();
    widget.controladorEditarPerfil.controladorNascimento.text =
        DateFormat('dd/MM/yyyy').format(widget.controladorPegarUsuario.modeloUsuario?.dataNascimento ?? DateTime.now());
    widget.controladorEditarPerfil.nascimentoData = widget.controladorPegarUsuario.modeloUsuario?.dataNascimento ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaEditarPerfilControlador>();

    return TextFormField(
      controller: controlador.controladorNascimento,
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
          initialDate: DateTime.now(), //controladorUsuario.usuarioModelo!.dataNascimento,
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
          locale: const Locale("pt", "BR"),
        );

        if (pegarData != null) {
          String dataFormatada = DateFormat('dd/MM/yyyy').format(pegarData);
          setState(() {
            controlador.nascimentoData = pegarData;
            controlador.controladorNascimento.text = dataFormatada.toString();
          });
        }
      },
    );
  }
}
