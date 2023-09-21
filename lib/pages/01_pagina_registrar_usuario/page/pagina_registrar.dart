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
    final controladorPaginaRegistrar = Provider.of<PaginaRegistrarUsuarioControlador>(context);
    return AbsorbPointer(
      absorbing: controladorPaginaRegistrar.carregando,
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 128, 16, 16),
            child: Stack(
              children: [
                Form(
                  key: controladorPaginaRegistrar.globalKeyPaginaRegistrar,
                  child: const Column(
                    children: [
                      PaginaRegistrarLogo(),
                      SizedBox(height: 16),
                      PaginaRegistrarCampoNome(),
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
                Positioned.fill(
                  child: Center(
                    child: Visibility(
                      visible: controladorPaginaRegistrar.carregando,
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
