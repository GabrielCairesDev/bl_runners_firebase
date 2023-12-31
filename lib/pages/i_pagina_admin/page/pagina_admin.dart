import 'package:bl_runners_app/pages/i_pagina_admin/components/pagina_admin_pesquisar.dart';
import 'package:bl_runners_app/pages/i_pagina_admin/controller/pagina_admin_controlador.dart';
import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_app/widgets/lista_de_usuarios/lista_de_usuarios_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaAdmin extends StatefulWidget {
  const PaginaAdmin({super.key});

  @override
  State<PaginaAdmin> createState() => _PaginaAdminState();
}

class _PaginaAdminState extends State<PaginaAdmin> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controlador = context.read<PaginaAdminControlador>();
      if (controlador.carregadoInitState == false) {
        controlador.carregarUsuarios();
        controlador.carregadoInitState = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controladorPaginaAdmin = Provider.of<PaginaAdminControlador>(context);
    final controladorPegarUsuarioAtual =
        Provider.of<PegarUsuarioAtual>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administração'),
      ),
      body: Column(
        children: [
          PaginaAdminPesquisar(controlador: controladorPaginaAdmin),
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    child: Icon(
                      Icons.home,
                      size: 200,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Visibility(
                    visible: controladorPaginaAdmin.carregando,
                    child: const Align(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                Visibility(
                  visible: controladorPaginaAdmin.carregando == false,
                  child: ListaDeUsuariosWidgets(
                    controladorPaginaAdmin: controladorPaginaAdmin,
                    controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
