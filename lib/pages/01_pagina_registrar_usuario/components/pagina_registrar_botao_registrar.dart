import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarBotaoRegistrar extends StatelessWidget {
  const PaginaRegistrarBotaoRegistrar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _registarUsuario(context),
        child: const Text('Registrar'),
      ),
    );
  }

  _registarUsuario(BuildContext context) {
    final controladorPaginaRegistrarUsuario = context.read<PaginaRegistrarUsuarioControlador>();
  }
}
