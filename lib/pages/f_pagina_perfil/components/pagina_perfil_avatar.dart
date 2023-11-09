import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PaginaPerfilAvatar extends StatelessWidget {
  const PaginaPerfilAvatar({super.key, required this.controlador});

  final PegarUsuarioAtual controlador;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: ClipOval(
        child: _avatarDoUsuario(),
      ),
    );
  }

  _avatarDoUsuario() {
    final avatarURL = controlador.usuarioAtual?.fotoUrl;
    if (avatarURL == null || avatarURL.isEmpty) {
      return Image.asset('assets/images/avatar.png', fit: BoxFit.cover);
    } else {
      return CachedNetworkImage(
        imageUrl: avatarURL,
        fit: BoxFit.cover,
        errorWidget: (context, error, stackTrace) {
          return Image.asset('assets/images/avatar.png', fit: BoxFit.cover);
        },
      );
    }
  }
}
