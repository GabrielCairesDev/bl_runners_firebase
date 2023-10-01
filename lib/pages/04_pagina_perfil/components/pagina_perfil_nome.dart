import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario.dart';
import 'package:flutter/material.dart';

class PaginaPerfilNome extends StatefulWidget {
  const PaginaPerfilNome({super.key, required this.controladorPegarUsuario});

  final PegarUsuario controladorPegarUsuario;

  @override
  State<PaginaPerfilNome> createState() => _PaginaPerfilNomeState();
}

class _PaginaPerfilNomeState extends State<PaginaPerfilNome> {
  @override
  Widget build(BuildContext context) {
    return Center(child: nomePerfil());
  }

  nomePerfil() {
    final nomeUsuario = widget.controladorPegarUsuario.modeloUsuario?.nome;

    final nome = nomeUsuario != null && nomeUsuario.isNotEmpty ? nomeUsuario : 'Nome Desconhecido';

    return Text(
      nome,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.width * 0.065,
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.visible,
    );
  }
}
