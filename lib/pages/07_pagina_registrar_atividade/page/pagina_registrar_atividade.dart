import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_botao.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_data.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_descricao.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_distancia.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_tempo.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_tipo.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_titulo.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarAtividade extends StatelessWidget {
  const PaginaRegistrarAtividade({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaRegistrarAtividadeControlador>(context);
    return AbsorbPointer(
      absorbing: controlador.carregando,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrar atividade'),
          actions: [
            PaginaRegistrarCampoBotao(
              controlador: controlador,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Stack(
              children: [
                Form(
                  key: controlador.globalKeyRegistrarAtividade,
                  child: Column(
                    children: [
                      PaginaRegistrarCampoTitulo(controlador: controlador),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      PaginaRegistrarCampoDescricao(controlador: controlador),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      PaginaRegistrarCampoData(controlador: controlador),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      PaginaRegistrarCampoTempo(controlador: controlador),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      PaginaRegistrarTipo(controlador: controlador),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      PaginaRegistrarCampoDistancia(controlador: controlador),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Visibility(
                    visible: controlador.carregando,
                    child: const Center(
                      child: CircularProgressIndicator(),
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
