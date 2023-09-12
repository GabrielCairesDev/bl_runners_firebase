import 'package:bl_runners_firebase/pages/pagina_inicio/components/pagina_inicio_botao_add.dart';
import 'package:flutter/material.dart';

class PaginaInicio extends StatelessWidget {
  const PaginaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBodyBehindAppBar: true, appBar: AppBar(title: const Text('Início')), floatingActionButton: const PaginaInicioBotaoAdd());
  }
}
