import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListaDeUsuariosFoto extends StatelessWidget {
  const ListaDeUsuariosFoto({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.height * 0.11,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: 'https://i.pinimg.com/736x/25/99/5a/25995a3e56511279f71ddfe531733abd.jpg',
          fit: BoxFit.cover,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
