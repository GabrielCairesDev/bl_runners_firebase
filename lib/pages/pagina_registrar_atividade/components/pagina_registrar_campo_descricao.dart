import 'package:flutter/material.dart';

class PaginaRegistrarCampoDescricao extends StatelessWidget {
  const PaginaRegistrarCampoDescricao({super.key});

  @override
  Widget build(BuildContext context) {
    // final controlador = context.read<ControladorPaginaRegistrarAtividade>();
    return Form(
      //  key: controlador.globalKeyCampoDescricao,
      child: TextFormField(
        //   validator: controlador.validadorDescricao,
        //   controller: controlador.controladorCampoDescricao,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Descrição',
          filled: false,
        ),
        minLines: 4,
        maxLines: 4,
      ),
    );
  }
}
