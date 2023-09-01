import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfilNascimento extends StatefulWidget {
  const PaginaEditarPerfilNascimento({super.key});

  @override
  State<PaginaEditarPerfilNascimento> createState() => _PaginaEditarPerfilNascimentoState();
}

class _PaginaEditarPerfilNascimentoState extends State<PaginaEditarPerfilNascimento> {
  @override
  void initState() {
    final controlador = context.read<PaginaEditarPerfilControlador>();
    final controladorUsuario = Provider.of<UserProvider>(context, listen: false);
    controlador.controladorNascimento.text = DateFormat('dd/MM/yyyy').format(controladorUsuario.usuarioModelo!.dataNascimento);
    controlador.nascimentoData = controladorUsuario.usuarioModelo!.dataNascimento;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaEditarPerfilControlador>();
    final controladorUsuario = Provider.of<UserProvider>(context, listen: false);

    return Form(
      key: controlador.globalKeyNascimento,
      child: TextFormField(
        controller: controlador.controladorNascimento,
        validator: controlador.validadorNascimento,
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
            initialDate: controladorUsuario.usuarioModelo!.dataNascimento,
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
      ),
    );
  }
}
