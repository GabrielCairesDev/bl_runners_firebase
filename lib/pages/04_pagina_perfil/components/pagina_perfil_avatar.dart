import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:flutter/material.dart';

class PaginaPerfilAvatar extends StatelessWidget {
  const PaginaPerfilAvatar({super.key, required this.controladorPegarUsuario});

  final PegarUsuarioAtual controladorPegarUsuario;

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
    final foto = controladorPegarUsuario.usuarioAtual?.fotoUrl;

    if (foto == null || foto.isEmpty) return Image.asset('assets/images/avatar.png');

    return Image.network(
      controladorPegarUsuario.usuarioAtual!.fotoUrl.toString(),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/avatar.png');
      },
    );
  }
}
