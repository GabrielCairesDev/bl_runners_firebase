import 'package:flutter/material.dart';

class PaginaEntrarBotaoEntrar extends StatelessWidget {
  const PaginaEntrarBotaoEntrar({super.key});

  @override
  Widget build(BuildContext context) {
    // final controlador = context.read<PaginaRegistrarControlador>();
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 1.0,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Entrar'),
      ),
    );
  }
}
