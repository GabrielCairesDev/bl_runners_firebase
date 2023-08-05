import 'package:flutter/material.dart';

import 'components/pagina_registrar_botao_registrar.dart';
import 'components/pagina_registrar_campo_confirmar_senha.dart';
import 'components/pagina_registrar_campo_email.dart';
import 'components/pagina_registrar_campo_senha.dart';
import 'components/pagina_registrar_logo.dart';

class PaginaRegistrar extends StatelessWidget {
  const PaginaRegistrar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 128, 16, 16),
          child: Column(
            children: [
              PaginaRegistrarLogo(),
              SizedBox(height: 16),
              PaginaRegistrarCampoEmail(),
              SizedBox(height: 16),
              PaginaRegistrarCampoSenha(),
              SizedBox(height: 16),
              PaginaRegistrarCampoConfirmarSenha(),
              SizedBox(height: 16),
              PaginaRegistrarBotaoRegistrar(),
            ],
          ),
        ),
      ),
    );
  }
}
