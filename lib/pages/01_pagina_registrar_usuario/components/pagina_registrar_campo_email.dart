import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoEmail extends StatelessWidget {
  const PaginaRegistrarCampoEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaRegistrar = context.read<PaginaRegistrarUsuarioControlador>();
    return TextFormField(
      controller: controladorPaginaRegistrar.controladorEmail,
      validator: controladorPaginaRegistrar.validadorEmail,
      decoration: const InputDecoration(
        hintText: 'Digite o seu e-mail',
        labelText: 'E-mail',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }
}
