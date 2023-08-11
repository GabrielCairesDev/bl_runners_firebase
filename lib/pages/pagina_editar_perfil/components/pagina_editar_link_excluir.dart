import 'package:flutter/material.dart';

class PaginaEditarLinkExcluir extends StatelessWidget {
  const PaginaEditarLinkExcluir({super.key});

  @override
  Widget build(BuildContext context) {
    return const InkWell(
      // onTap: () => context.push(Rotas.registrar),
      child: Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Text(
          'Excluir conta',
          textAlign: TextAlign.center,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
