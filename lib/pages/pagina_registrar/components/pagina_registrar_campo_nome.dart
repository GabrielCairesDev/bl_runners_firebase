import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoNome extends StatelessWidget {
  const PaginaRegistrarCampoNome({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaRegistrarControlador>();
    return Form(
      key: controlador.globalKeyNome,
      child: TextFormField(
        controller: controlador.controladorNome,
        validator: controlador.validadorNome,
        decoration: const InputDecoration(
          hintText: 'Digite o seu nome',
          labelText: 'Nome',
          prefixIcon: Icon(Icons.person),
        ),
      ),
    );
  }
}
