import 'package:flutter/material.dart';

class ListaData extends StatelessWidget {
  const ListaData({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.width * 0.04,
      ),
    );
  }
}
