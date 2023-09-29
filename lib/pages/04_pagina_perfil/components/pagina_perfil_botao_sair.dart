import 'package:bl_runners_firebase/pages/04_pagina_perfil/controller/pagina_perfil_controlador.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaEditarBotaoSair extends StatelessWidget {
  const PaginaEditarBotaoSair({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _sair(context),
      icon: const Icon(Icons.exit_to_app),
    );
  }

  _sair(BuildContext context) async {
    final controladorPaginaPerfil = context.read<PaginaPerfilControlador>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    controladorPaginaPerfil.sair().then((value) async {
      prefs.setBool("entradaAutomatica", false);
      context.pushReplacement(Rotas.entrar);
      debugPrint(value);
    }).catchError((onError) {
      Mensagens.mensagemErro(context, texto: onError);
    });
  }
}
