import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListaDeUsuariosFoto extends StatelessWidget {
  const ListaDeUsuariosFoto({super.key, required this.foto});

  final String foto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.height * 0.11,
      height: MediaQuery.of(context).size.height * 0.11,
      child: ClipOval(
        child: _avatarDoUsuario(),
      ),
    );
  }

  _avatarDoUsuario() {
    final avatarURL = foto;
    if (avatarURL.isEmpty) {
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
