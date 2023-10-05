import 'package:flutter/material.dart';

class ListaDistancia extends StatelessWidget {
  const ListaDistancia({super.key, required this.distancia});

  final int distancia;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Distância',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          '${distancia / 1000} km',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
