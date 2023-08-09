import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_concluir_controlador.dart';

class PaginaConcluirBotaoSair extends StatelessWidget {
  const PaginaConcluirBotaoSair({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaConcluirControlador>(context);
    return IconButton(
      onPressed: () => controlador.sair(context),
      icon: const Icon(Icons.exit_to_app),
    );
  }
}
