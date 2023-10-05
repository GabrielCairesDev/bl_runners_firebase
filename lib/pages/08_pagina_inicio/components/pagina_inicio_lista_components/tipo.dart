import 'package:flutter/material.dart';

class ListaTipo extends StatelessWidget {
  const ListaTipo({super.key, required this.tipo});

  final String tipo;

  @override
  Widget build(BuildContext context) {
    return Text(
      tipo,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: tipo == 'Prova' ? const Color(0xFFc1d22b) : const Color(0xFF2e355a),
      ),
    );
  }
}
