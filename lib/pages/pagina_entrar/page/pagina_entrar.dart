import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_botao_entrar.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_campo_email.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_campo_senha.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_link_recuperar.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_link_registrar.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_logo.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/components/pagina_entrar_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_entrar_controlador.dart';

class PaginaEntrar extends StatelessWidget {
  const PaginaEntrar({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaEntrarControlador>(context);
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 128, 16, 16),
          child: Stack(
            children: [
              const Column(
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
              Positioned.fill(
                child: Center(
                  child: Visibility(
                      visible: controlador.carregando,
                      child: const CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const PaginEntrarLinkRegistrar(),
    );
  }
}
