import 'package:bl_runners_firebase/pages/05_pagina_editar_perfil/components/pagina_editar_link_excluir.dart';
import 'package:bl_runners_firebase/pages/05_pagina_editar_perfil/components/pagina_editar_perfil_foto.dart';
import 'package:bl_runners_firebase/pages/05_pagina_editar_perfil/components/pagina_editar_perfil_nome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/pagina_editar_botao_editar.dart';
import '../components/pagina_editar_perfil_genero.dart';
import '../components/pagina_editar_perfil_nascimento.dart';
import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfil extends StatelessWidget {
  const PaginaEditarPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaEditarPerfilControlador>(context);
    return AbsorbPointer(
      absorbing: controlador.carregando,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Perfil'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                const Column(
                  children: [
                    PaginaEditarPerfilNome(),
                    SizedBox(height: 8),
                    PaginaEditarPerfilGenero(),
                    SizedBox(height: 8),
                    PaginaEditarPerfilNascimento(),
                    SizedBox(height: 8),
                    PaginaEditarPerfilFoto(),
                    SizedBox(height: 8),
                    PaginaEditarBotaoEditar()
                  ],
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
        bottomNavigationBar: const PaginaEditarLinkExcluir(),
      ),
    );
  }
}
