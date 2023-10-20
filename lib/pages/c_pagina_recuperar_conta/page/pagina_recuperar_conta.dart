import 'package:bl_runners_firebase/pages/d_pagina_entrar/components/pagina_entrar_logo.dart';
import 'package:bl_runners_firebase/pages/c_pagina_recuperar_conta/components/pagina_recuperar_conta_botao.dart';
import 'package:bl_runners_firebase/pages/c_pagina_recuperar_conta/components/pagina_recuperar_conta_campo_email.dart';
import 'package:bl_runners_firebase/pages/c_pagina_recuperar_conta/controller/pagina_recuperar_conta_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRecuperarConta extends StatelessWidget {
  const PaginaRecuperarConta({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaRecuperarContaControlador>(context);

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
                  key: controlador.globalKeyEmailPaginaRecuperar,
                  child: Column(
                    children: [
                      const PaginaEntrarLogo(),
                      const SizedBox(height: 16),
                      PaginaRecuperarContaCampoEmail(
                        controlador: controlador,
                      ),
                      const SizedBox(height: 16),
                      PaginaRecuperarContaBotao(controlador: controlador),
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
      ),
    );
  }
}
