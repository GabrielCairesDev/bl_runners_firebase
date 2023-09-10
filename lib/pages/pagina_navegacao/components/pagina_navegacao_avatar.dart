import 'package:flutter/material.dart';

class PaginaNavegacaoAvatar extends StatefulWidget {
  const PaginaNavegacaoAvatar({super.key});

  @override
  State<PaginaNavegacaoAvatar> createState() => _PaginaNavegacaoAvatarState();
}

class _PaginaNavegacaoAvatarState extends State<PaginaNavegacaoAvatar> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
      height: 24,
      child: ClipOval(
          // child: Image.network(
          //   usuarioProvider.usuarioModelo!.fotoUrl.toString(),
          //   fit: BoxFit.cover,
          // ),
          ),
    );
  }
}
