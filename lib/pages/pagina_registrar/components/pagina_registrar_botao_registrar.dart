import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarBotaoRegistrar extends StatelessWidget {
  const PaginaRegistrarBotaoRegistrar({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaRegistrarControlador>();
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 1.0,
      child: ElevatedButton(
        onPressed: () => controlador.validarCampos(context),
        child: const Text('Registrar'),
      ),
    );
  }
}
