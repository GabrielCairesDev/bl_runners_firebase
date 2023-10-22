import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/rotas.dart';

class PaginEntrarLinkRegistrar extends StatelessWidget {
  const PaginEntrarLinkRegistrar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Não é registrado? ',
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
          InkWell(
            onTap: () => context.push(Rotas.registrarUsuario),
            child: const Text(
              'Registre-se',
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
