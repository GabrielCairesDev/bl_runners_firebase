import 'package:flutter/material.dart';

class ListaDeAtividadeRitmo extends StatelessWidget {
  const ListaDeAtividadeRitmo({super.key, required this.ritmo});

  final String ritmo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ritmo',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          ritmo,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
