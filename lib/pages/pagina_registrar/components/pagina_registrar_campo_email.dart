import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoEmail extends StatelessWidget {
  const PaginaRegistrarCampoEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaRegistrarControlador>();
    return Form(
      key: controlador.globalKeyEmail,
      child: TextFormField(
        controller: controlador.controladorEmail,
        validator: controlador.validadorEmail,
        decoration: const InputDecoration(
          hintText: 'Digite o seu e-mail',
          labelText: 'E-mail',
          prefixIcon: Icon(Icons.email),
        ),
      ),
    );
  }
}
