import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/rotas.dart';

class PaginEntrarLinkRegistrar extends StatelessWidget {
  const PaginEntrarLinkRegistrar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(Rotas.registrar),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Text(
          'Não é registrado? Registre-se',
          textAlign: TextAlign.center,
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
