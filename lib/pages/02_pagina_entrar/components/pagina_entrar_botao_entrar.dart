import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  _entrar(BuildContext context) async {
    final controladorPaginaEntrar = context.read<PaginaEntrarControlador>();

    FocusScope.of(context).unfocus();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    controladorPaginaEntrar.entrar().then((value) {
      debugPrint(value);
      context.pushReplacement(Rotas.navegar);
      prefs.setBool("entradaAutomatica", controladorPaginaEntrar.entradaAutomatica);
      controladorPaginaEntrar.resetarValores();
      controladorPaginaEntrar.atualizarEstadoCarregando();
    }).catchError((onError) {
      Mensagens.mensagemErro(context, texto: onError);
      controladorPaginaEntrar.atualizarEstadoCarregando();
    });
  }
}
