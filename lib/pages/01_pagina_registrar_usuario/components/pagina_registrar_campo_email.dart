import 'package:flutter/material.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoEmail extends StatelessWidget {
  const PaginaRegistrarCampoEmail({super.key, required this.controlador});

  final PaginaRegistrarUsuarioControlador controlador;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador.controladorEmail,
      validator: controlador.validadorEmail,
      decoration: const InputDecoration(
        hintText: 'Digite o seu e-mail',
        labelText: 'E-mail',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }
}
