import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListaDeUsuariosNome extends StatelessWidget {
  const ListaDeUsuariosNome({super.key, required this.nome, required this.dataAniversario});

  final String nome;
  final DateTime dataAniversario;

  @override
  Widget build(BuildContext context) {
    String data = DateFormat('dd/MM/yyyy').format(dataAniversario);
    return Text(
      '$nome - $data',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.width * 0.04,
      ),
    );
  }
}
