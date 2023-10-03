import 'package:bl_runners_firebase/pages/02_pagina_entrar/components/pagina_entrar_botao_entrar.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/components/pagina_entrar_campo_email.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/components/pagina_entrar_campo_senha.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/components/pagina_entrar_link_recuperar.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/components/pagina_entrar_link_registrar.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/components/pagina_entrar_logo.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/components/pagina_entrar_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_entrar_controlador.dart';

class PaginaEntrar extends StatefulWidget {
  const PaginaEntrar({super.key});

  @override
  State<PaginaEntrar> createState() => _PaginaEntrarState();
}

class _PaginaEntrarState extends State<PaginaEntrar> {
  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaEntrarControlador>(context);
    return AbsorbPointer(
      absorbing: controlador.carregando,
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 128, 16, 16),
            child: Stack(
              children: [
                Form(
                  key: controlador.globalKeyEmailPaginaEntrar,
                  child: Column(
                    children: [
                      const PaginaEntrarLogo(),
                      const SizedBox(height: 16),
                      PaginaEntrarCampoEmail(
                        controlador: controlador,
                      ),
                      const SizedBox(height: 16),
                      PaginaEntrarCampoSenha(controlador: controlador),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PaginaEntrarSwitch(controlador: controlador),
                          PaginaEntrarLinkRecuperar(controlador: controlador),
                        ],
                      ),
                      PaginaEntrarBotaoEntrar(controlador: controlador),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Visibility(
                      visible: controlador.carregando,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const PaginEntrarLinkRegistrar(),
      ),
    );
  }
}
