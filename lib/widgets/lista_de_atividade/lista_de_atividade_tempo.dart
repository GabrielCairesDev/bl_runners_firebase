import 'package:flutter/material.dart';

class ListaDeAtivdadeTempo extends StatelessWidget {
  const ListaDeAtivdadeTempo({super.key, required this.tempo});

  final String tempo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tempo',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          tempo,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
