import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PaginaEntrarBotaoEntrar extends StatelessWidget {
  const PaginaEntrarBotaoEntrar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _entrar(context),
        child: const Text('Entrar'),
      ),
    );
  }

  _entrar(BuildContext context) {
    final controladorPaginaEntrar = context.read<PaginaEntrarControlador>();

    controladorPaginaEntrar.atualizarEstadoCarregando();
    controladorPaginaEntrar.entrar().then(
          (value) => {
            if (value)
              {
                if (context.mounted) context.pushReplacement(Rotas.navegar),
                controladorPaginaEntrar.resetarValores(),
                debugPrint('ok'),
              }
            else
              {
                debugPrint('erro'),
              },
            controladorPaginaEntrar.atualizarEstadoCarregando(),
          },
        );
  }
}
