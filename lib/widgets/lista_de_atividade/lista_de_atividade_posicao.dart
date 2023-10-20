import 'package:bl_runners_firebase/utils/utilitarios.dart';
import 'package:flutter/material.dart';

class ListaAtividadePosicao extends StatelessWidget {
  const ListaAtividadePosicao({
    super.key,
    required this.index,
    required this.mes,
    required this.ano,
  });

  final int index;
  final int mes;
  final int ano;

  @override
  Widget build(BuildContext context) {
    String mesAno = Utilitarios().mesAnoPorExtenso(mes, ano);
    return Text(
      '${index + 1}° Lugar - $mesAno',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.width * 0.04,
      ),
    );
  }
}
