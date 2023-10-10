import 'package:flutter/material.dart';

class ListaDeAtividadeMedalha extends StatelessWidget {
  const ListaDeAtividadeMedalha({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.height * 0.04,
      child: Image(
        image: const AssetImage('assets/images/medalha.png'),
        color: Logica.getCor(index),
      ),
    );
  }
}

enum Medalha {
  ouro,
  prata,
  bronze,
}

class Logica {
  static Color getCor(int posicao) {
    switch (posicao) {
      case 0:
        return Colors.yellow;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.brown;
      default:
        return Colors.transparent;
    }
  }
}
