import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListaDeUsuariosFoto extends StatelessWidget {
  const ListaDeUsuariosFoto({super.key, required this.foto});

  final String foto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.height * 0.11,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: foto,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
