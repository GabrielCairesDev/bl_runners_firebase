import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_botao.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_data.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_descricao.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_distancia.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_tempo.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_tipo.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/components/pagina_registrar_campo_titulo.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarAtividade extends StatelessWidget {
  const PaginaRegistrarAtividade({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaRegistrarAtividade = Provider.of<PaginaRegistrarAtividadeControlador>(context);
    final controladorPegarUsuarioAtual = Provider.of<PegarUsuarioAtual>(context);
    return AbsorbPointer(
      absorbing: controladorPaginaRegistrarAtividade.carregando,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrar atividade'),
          actions: [
            PaginaRegistrarCampoBotao(
              controladorPaginaRegistrarAtividade: controladorPaginaRegistrarAtividade,
              controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Stack(
              children: [
                Form(
                  key: controladorPaginaRegistrarAtividade.globalKeyRegistrarAtividade,
                  child: Column(
                    children: [
                      PaginaRegistrarCampoTitulo(controlador: controladorPaginaRegistrarAtividade),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      PaginaRegistrarCampoDescricao(controlador: controladorPaginaRegistrarAtividade),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      PaginaRegistrarCampoData(controlador: controladorPaginaRegistrarAtividade),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      PaginaRegistrarCampoTempo(controlador: controladorPaginaRegistrarAtividade),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      PaginaRegistrarTipo(controlador: controladorPaginaRegistrarAtividade),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      PaginaRegistrarCampoDistancia(controlador: controladorPaginaRegistrarAtividade),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Visibility(
                    visible: controladorPaginaRegistrarAtividade.carregando,
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
