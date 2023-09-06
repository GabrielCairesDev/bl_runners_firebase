import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarCampoDescricao extends StatelessWidget {
  const PaginaRegistrarCampoDescricao({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaRegistrarAtividadeControlador>();
    return Form(
      key: controlador.globalKeyCampoDescricao,
      child: TextFormField(
        validator: controlador.validadorDescricao,
        controller: controlador.controladorCampoDescricao,
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
