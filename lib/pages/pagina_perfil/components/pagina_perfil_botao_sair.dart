import 'package:bl_runners_firebase/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaEditarBotaoSair extends StatelessWidget {
  const PaginaEditarBotaoSair({super.key});

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context, listen: false);
    return IconButton(
      onPressed: () => authprovider.sair(context),
      icon: const Icon(Icons.exit_to_app),
    );
  }
}
