import 'package:bl_runners_firebase/providers/pegar_usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaPerfilAvatar extends StatelessWidget {
  const PaginaPerfilAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: ClipOval(
        child: fotoPerfil(context),
      ),
    );
  }

  fotoPerfil(BuildContext context) {
    final controladorDataProvider = Provider.of<PegarUsuario>(context);
    final foto = controladorDataProvider.modeloUsuario?.fotoUrl;

    if (foto == null || foto.isEmpty) {
      return Image.asset('assets/images/avatar.png');
    }

    return Image.network(
      controladorDataProvider.modeloUsuario!.fotoUrl.toString(),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/avatar.png');
      },
    );
  }
}
