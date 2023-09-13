import 'package:bl_runners_firebase/pages/pagina_inicio/components/pagina_inicio_botao_add.dart';
import 'package:bl_runners_firebase/pages/pagina_inicio/controller/pagina_inicio_controlador.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaIncio = Provider.of<PaginaInicioControlador>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Início')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 96),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => controladorPaginaIncio.listaDocumentos(),
                  child: const Icon(Icons.catching_pokemon),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const PaginaInicioBotaoAdd(),
    );
  }
}
