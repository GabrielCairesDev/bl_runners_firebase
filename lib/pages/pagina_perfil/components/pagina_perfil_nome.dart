import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider_usuario.dart';

class PaginaPerfilNome extends StatelessWidget {
  const PaginaPerfilNome({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorUsuario = Provider.of<ProviderUsuario>(context);
    return Center(
      child: Text(
        controladorUsuario.usuario!.nome.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width * 0.065,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 1),
              blurRadius: 2,
            ),
          ],
        ),
        maxLines: 1,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
