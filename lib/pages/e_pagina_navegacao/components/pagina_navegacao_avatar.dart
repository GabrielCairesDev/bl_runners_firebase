import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PaginaNavegacaoAvatar extends StatelessWidget {
  const PaginaNavegacaoAvatar({super.key, required this.controlador});

  final PegarUsuarioAtual controlador;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: ClipOval(
        child: _fotoPerfil(),
      ),
    );
  }

  _fotoPerfil() {
    final fotoUrl = controlador.usuarioAtual?.fotoUrl;
    if (fotoUrl == null || fotoUrl.isEmpty) {
      return Image.asset('assets/images/avatar.png', fit: BoxFit.cover);
    } else {
      return CachedNetworkImage(
        imageUrl: fotoUrl,
        fit: BoxFit.cover,
        errorWidget: (context, error, stackTrace) {
          return Image.asset('assets/images/avatar.png', fit: BoxFit.cover);
        },
      );
    }
  }
}
