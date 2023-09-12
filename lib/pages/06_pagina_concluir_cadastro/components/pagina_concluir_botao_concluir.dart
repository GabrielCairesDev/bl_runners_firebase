import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_concluir_controlador.dart';

class PaginaConcluirBotaoConcluir extends StatelessWidget {
  const PaginaConcluirBotaoConcluir({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaConcluirControlador>();
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 1.0,
      child: ElevatedButton(
        onPressed: () {
          controlador.validarCampos(context);
        },
        child: const Text('Concluir'),
      ),
    );
  }
}
