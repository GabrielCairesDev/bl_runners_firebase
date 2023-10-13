import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaNavegacaoAvatar extends StatefulWidget {
  const PaginaNavegacaoAvatar({super.key});

  @override
  State<PaginaNavegacaoAvatar> createState() => _PaginaNavegacaoAvatarState();
}

class _PaginaNavegacaoAvatarState extends State<PaginaNavegacaoAvatar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: ClipOval(
        child: fotoPerfil(),
      ),
    );
  }

  fotoPerfil() {
    final controladorDataProvider = Provider.of<PegarUsuarioAtual>(context);
    if (controladorDataProvider.usuarioAtual?.fotoUrl == null || controladorDataProvider.usuarioAtual!.fotoUrl.isEmpty) {
      return Image.asset('assets/images/avatar.png');
    } else {
      return CachedNetworkImage(
        imageUrl: controladorDataProvider.usuarioAtual!.fotoUrl.toString(),
        fit: BoxFit.cover,
        errorWidget: (context, error, stackTrace) {
          return Image.asset('assets/images/avatar.png');
        },
      );
    }
  }
}
