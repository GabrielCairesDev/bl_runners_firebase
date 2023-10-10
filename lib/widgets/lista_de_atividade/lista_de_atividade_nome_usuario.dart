import 'package:flutter/material.dart';

class ListaAtividadeNomeUsuario extends StatelessWidget {
  const ListaAtividadeNomeUsuario({super.key, required this.nome});

  final String nome;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.55,
      child: Text(
        nome,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
