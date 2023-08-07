import 'package:bl_runners_firebase/pages/pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaEntrarBotaoEntrar extends StatelessWidget {
  const PaginaEntrarBotaoEntrar({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaEntrarControlador>();
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 1.0,
      child: ElevatedButton(
        onPressed: () => controlador.validarCampos(context),
        child: const Text('Entrar'),
      ),
    );
  }
}
