import 'package:flutter/material.dart';

class ListaDeAtividadeTipoAtividade extends StatelessWidget {
  const ListaDeAtividadeTipoAtividade({super.key, required this.tipo});

  final String tipo;

  @override
  Widget build(BuildContext context) {
    // return tipo == 'Prova'
    //     ? Icon(
    //         Icons.emoji_events_outlined,
    //         size: MediaQuery.of(context).size.height * 0.04,
    //         color: const Color(0xFFc1d22b),
    //       )
    //     : Icon(
    //         Icons.directions_run,
    //         size: MediaQuery.of(context).size.height * 0.04,
    //         color: const Color(0xFF2e355a),
    //       );
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
