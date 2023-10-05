import 'package:flutter/material.dart';

class ListaBotao extends StatelessWidget {
  const ListaBotao({super.key, required this.usuarioListaID, required this.usuarioAtualID});

  final String usuarioListaID;
  final String usuarioAtualID;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        usuarioListaID == usuarioAtualID
            ? InkWell(
                onTap: () => print('deletar'),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 20,
                ),
              )
            : const SizedBox(width: 20), // Substituí null por SizedBox com largura 20 para evitar erro de layout
        const SizedBox(width: 6)
      ],
    );
  }
}
