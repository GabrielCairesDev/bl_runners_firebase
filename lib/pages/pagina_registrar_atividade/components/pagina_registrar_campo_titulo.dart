import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarCampoTitulo extends StatelessWidget {
  const PaginaRegistrarCampoTitulo({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaRegistrarAtividadeControlador>();
    return Form(
      key: controlador.globalKeyCampoTitulo,
      child: TextFormField(
        validator: controlador.validadorTitulo,
        controller: controlador.controladorCampoTitulo,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Título',
          filled: false,
        ),
      ),
    );
  }
}
