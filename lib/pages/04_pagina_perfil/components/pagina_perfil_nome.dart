import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaPerfilNome extends StatefulWidget {
  const PaginaPerfilNome({super.key});

  @override
  State<PaginaPerfilNome> createState() => _PaginaPerfilNomeState();
}

class _PaginaPerfilNomeState extends State<PaginaPerfilNome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: nomePerfil(),
    );
  }

  nomePerfil() {
    final controladorDataProvider = Provider.of<PegarUsuario>(context);
    final nomeUsuario = controladorDataProvider.modeloUsuario?.nome;

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
