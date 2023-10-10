import 'package:flutter/material.dart';

class ListaDeAtividadeFotoPerfil extends StatelessWidget {
  const ListaDeAtividadeFotoPerfil({super.key, required this.foto});

  final String foto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.height * 0.11,
      child: ClipOval(
        child: Image.network(
          foto,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
