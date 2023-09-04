import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/components/pagina_registrar_campo_botao.dart';
import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/components/pagina_registrar_campo_data.dart';
import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/components/pagina_registrar_campo_descricao.dart';
import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/components/pagina_registrar_campo_distancia.dart';
import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/components/pagina_registrar_campo_tempo.dart';
import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/components/pagina_registrar_campo_tipo.dart';
import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/components/pagina_registrar_campo_titulo.dart';
import 'package:flutter/material.dart';

class PaginaRegistrarAtividade extends StatelessWidget {
  const PaginaRegistrarAtividade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar atividade'),
        actions: const [PaginaRegistrarCampoBotao()],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Stack(
            children: [
              Column(
                children: [
                  const PaginaRegistrarCampoTitulo(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const PaginaRegistrarCampoDescricao(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const PaginaRegistrarCampoData(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const PaginaRegistrarCampoTempo(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const PaginaRegistrarTipo(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const PaginaRegistrarCampoDistancia(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
              // Positioned.fill(
              //   child: Visibility(
              //     visible: controlador.mostrarCarregando,
              //     child: const Center(
              //       child: CircularProgressIndicator(),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
