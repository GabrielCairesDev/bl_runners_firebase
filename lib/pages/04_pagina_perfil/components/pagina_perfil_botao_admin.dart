import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaPerfilBotaoSair extends StatelessWidget {
  const PaginaPerfilBotaoSair({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.push(Rotas.adm),
      icon: const Icon(Icons.manage_accounts),
    );
  }
}
