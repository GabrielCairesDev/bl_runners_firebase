import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarCampoBotao extends StatelessWidget {
  const PaginaRegistrarCampoBotao({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaRegistrarAtividadeControlador>();
    return IconButton(
      onPressed: () => controlador.validar(),
      icon: const Icon(Icons.save),
    );
  }
}
