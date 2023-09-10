import 'package:flutter/material.dart';

class PaginaPerfilAvatar extends StatelessWidget {
  const PaginaPerfilAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: const ClipOval(
          // child: Image.network(
          //   controladorUsuario.usuarioModelo!.fotoUrl.toString(),
          //   fit: BoxFit.cover,
          // ),
          ),
    );
  }
}
