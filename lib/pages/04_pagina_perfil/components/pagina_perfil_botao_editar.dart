import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaPerfilBotaoEditar extends StatelessWidget {
  const PaginaPerfilBotaoEditar({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => GoRouter.of(context).push(Rotas.editar),
      child: const Icon(Icons.edit),
    );
  }
}
