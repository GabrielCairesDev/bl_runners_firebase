import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_entrar_controlador.dart';

class PaginaEntrarCampoEmail extends StatelessWidget {
  const PaginaEntrarCampoEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaEntrar = context.read<PaginaEntrarControlador>();
    return TextFormField(
      controller: controladorPaginaEntrar.controladorEmail,
      validator: controladorPaginaEntrar.validadorEmail,
      decoration: const InputDecoration(
        hintText: 'Digite o seu e-mail',
        labelText: 'E-mail',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }
}
