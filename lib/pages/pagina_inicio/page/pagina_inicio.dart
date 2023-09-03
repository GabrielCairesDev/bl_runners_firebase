import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Início')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Rotas.adicionar),
        child: const Icon(Icons.add),
      ),
    );
  }
}
