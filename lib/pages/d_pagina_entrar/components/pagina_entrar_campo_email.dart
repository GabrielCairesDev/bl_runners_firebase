import 'package:bl_runners_app/utils/validadores.dart';
import 'package:flutter/material.dart';

import '../controller/pagina_entrar_controlador.dart';

class PaginaEntrarCampoEmail extends StatelessWidget {
  const PaginaEntrarCampoEmail({super.key, required this.controlador});

  final PaginaEntrarControlador controlador;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador.controladorEmail,
      validator: Validador.email,
      decoration: const InputDecoration(
        hintText: 'Digite o seu e-mail',
        labelText: 'E-mail',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }
}
