import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_botao_add.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_botao_filtro.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_lista.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario.dart';

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
    final controladorPegarUsuario = Provider.of<PegarUsuario>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          PaginaInicioBotaoFiltro(
            controladorPaginaInicial: controladorPaginaInicial,
          )
        ],
        title: const Text('Início'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            PaginaInicioLista(controladorPaginaInicial: controladorPaginaInicial),
            Positioned.fill(
              child: Visibility(
                visible: controladorPaginaInicial.carregando,
                child: const Align(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: PaginaInicioBotaoAdd(
        controlador: controladorPegarUsuario,
      ),
    );
  }
}
