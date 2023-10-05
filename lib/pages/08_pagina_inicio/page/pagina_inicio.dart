import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_botao_add.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_botao_filtro.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_lista.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaInicio extends StatefulWidget {
  const PaginaInicio({super.key});

  @override
  State<PaginaInicio> createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controlador = context.read<PaginaInicioControlador>();
      if (controlador.carregadoInitState == false) {
        controlador.carregarAtividades();
        controlador.carregadoInitState = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controladorPaginaInicial = Provider.of<PaginaInicioControlador>(context);
    final controladorPegarUsuarioAtual = Provider.of<PegarUsuarioAtual>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Início'),
        actions: [
          PaginaInicioBotaoFiltro(
            controladorPaginaInicial: controladorPaginaInicial,
          )
        ],
      ),
      body: Stack(
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
              visible: controladorPaginaInicial.carregando,
              child: const Align(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          PaginaInicioLista(controladorPaginaInicial: controladorPaginaInicial, controladorPegarUsuarioAtual: controladorPegarUsuarioAtual),
        ],
      ),
      floatingActionButton: PaginaInicioBotaoAdd(
        controlador: controladorPegarUsuarioAtual,
      ),
    );
  }
}
