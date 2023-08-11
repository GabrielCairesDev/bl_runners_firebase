import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider_usuario.dart';

class PaginaPerfilAvatar extends StatelessWidget {
  const PaginaPerfilAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorUsuario = Provider.of<ProviderUsuario>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: ClipOval(
        child: Image.network(
          controladorUsuario.usuario!.fotoUrl.toString(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
