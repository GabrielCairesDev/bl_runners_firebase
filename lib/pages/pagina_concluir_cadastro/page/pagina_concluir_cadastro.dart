import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/rotas.dart';

class PaginaConcluirCadastro extends StatelessWidget {
  const PaginaConcluirCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Concluir Cadastro'),
      ),
      body: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            if (context.mounted) context.pushReplacement(Rotas.entrar);
          },
          child: const Icon(Icons.exit_to_app)),
    );
  }
}
