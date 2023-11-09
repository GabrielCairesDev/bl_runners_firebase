import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:flutter/material.dart';

class PaginaPerfilNome extends StatefulWidget {
  const PaginaPerfilNome({super.key, required this.controladorPegarUsuario});

  final PegarUsuarioAtual controladorPegarUsuario;

  @override
  State<PaginaPerfilNome> createState() => _PaginaPerfilNomeState();
}

class _PaginaPerfilNomeState extends State<PaginaPerfilNome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _nomeDoUsuario(),
    );
  }

  _nomeDoUsuario() {
    final nomeDoUsuario = widget.controladorPegarUsuario.usuarioAtual?.nome ??
        'Nome Desconhecido';

    return Text(
      nomeDoUsuario,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.width * 0.065,
        color: Colors.white,
        shadows: [
          Shadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 1),
              blurRadius: 2)
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
