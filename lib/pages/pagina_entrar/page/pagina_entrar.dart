import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_botao_entrar.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_campo_email.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_campo_senha.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_link_recuperar.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_link_registrar.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_logo.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_switch.dart';
import 'package:flutter/material.dart';

class PaginaEntrar extends StatelessWidget {
  const PaginaEntrar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 128, 16, 16),
          child: Column(
            children: [
              PaginaEntrarLogo(),
              SizedBox(height: 16),
              PaginaEntrarCampoEmail(),
              SizedBox(height: 16),
              PaginaEntrarCampoSenha(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PaginaEntrarSwitch(),
                  PaginaEntrarLinkRecuperar(),
                ],
              ),
              PaginaEntrarBotaoEntrar(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PaginEntrarLinkRegistrar(),
    );
  }
}
