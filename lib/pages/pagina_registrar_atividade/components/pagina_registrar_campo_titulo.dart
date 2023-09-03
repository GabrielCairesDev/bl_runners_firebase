import 'package:flutter/material.dart';

class PaginaRegistrarCampoTitulo extends StatelessWidget {
  const PaginaRegistrarCampoTitulo({super.key});

  @override
  Widget build(BuildContext context) {
    //final controlador = context.read<ControladorPaginaRegistrarAtividade>();
    return Form(
      //  key: controlador.globalKeyCampoTitulo,
      child: TextFormField(
        //  validator: controlador.validadorTitulo,
        // controller: controlador.controladorCampoTitulo,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Título',
          filled: false,
        ),
      ),
    );
  }
}
