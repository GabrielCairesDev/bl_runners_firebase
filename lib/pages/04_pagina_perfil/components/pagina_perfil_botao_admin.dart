import 'package:flutter/material.dart';

class PaginaPerfilBotaoSair extends StatelessWidget {
  const PaginaPerfilBotaoSair({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => print('ok'),
      icon: const Icon(Icons.manage_accounts),
    );
  }
}
