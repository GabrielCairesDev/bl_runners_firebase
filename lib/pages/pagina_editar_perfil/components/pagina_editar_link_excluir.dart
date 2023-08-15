import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarLinkExcluir extends StatelessWidget {
  const PaginaEditarLinkExcluir({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaEditarPerfilControlador>(context);
    return InkWell(
      onTap: () => controlador.pedirsenha(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
          child: const Text(
            'Excluir Perfil',
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
