import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaEntrarLinkRecuperar extends StatelessWidget {
  const PaginaEntrarLinkRecuperar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(Rotas.recuperarConta),
      child: const Text(
        'Recuperar conta',
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
