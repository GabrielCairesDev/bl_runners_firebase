import 'package:bl_runners_firebase/pages/b_pagina_registrar_usuario/components/pagina_registrar_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/pagina_registrar_botao_registrar.dart';
import '../components/pagina_registrar_campo_confirmar_senha.dart';
import '../components/pagina_registrar_campo_email.dart';
import '../components/pagina_registrar_campo_nome.dart';
import '../components/pagina_registrar_campo_senha.dart';
import '../components/pagina_registrar_logo.dart';
import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrar extends StatefulWidget {
  const PaginaRegistrar({super.key});

  @override
  State<PaginaRegistrar> createState() => _PaginaRegistrarState();
}

class _PaginaRegistrarState extends State<PaginaRegistrar> {
  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaRegistrarUsuarioControlador>(context);
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
                  key: controlador.globalKeyPaginaRegistrar,
                  child: Column(
                    children: [
                      const PaginaRegistrarLogo(),
                      const SizedBox(height: 16),
                      PaginaRegistrarCampoNome(controlador: controlador),
                      const SizedBox(height: 16),
                      PaginaRegistrarCampoEmail(controlador: controlador),
                      const SizedBox(height: 16),
                      PaginaRegistrarCampoSenha(controlador: controlador),
                      const SizedBox(height: 16),
                      PaginaRegistrarCampoConfirmarSenha(controlador: controlador),
                      const SizedBox(height: 16),
                      PaginaRegistrarBotaoRegistrar(controlador: controlador),
                      const SizedBox(height: 16),
                      PaginaRegistrarCheckBox(controlador: controlador)
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
