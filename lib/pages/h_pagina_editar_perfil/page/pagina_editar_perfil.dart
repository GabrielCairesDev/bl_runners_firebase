import 'package:bl_runners_firebase/pages/h_pagina_editar_perfil/components/pagina_editar_bota_excluir.dart';
import 'package:bl_runners_firebase/pages/h_pagina_editar_perfil/components/pagina_editar_perfil_foto.dart';
import 'package:bl_runners_firebase/pages/h_pagina_editar_perfil/components/pagina_editar_perfil_nome.dart';
import 'package:bl_runners_firebase/providers/firebase/snapshot/pegar_usuario_atual.dart';
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
    final controladorEditarPerfil = Provider.of<PaginaEditarPerfilControlador>(context);
    final controladorPegarUsuarioAtual = Provider.of<PegarUsuarioAtual>(context);
    return AbsorbPointer(
      absorbing: controladorEditarPerfil.carregando,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Perfil'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Form(
                  key: controladorEditarPerfil.globalKeyPaginaEditarPerfil,
                  child: Column(
                    children: [
                      PaginaEditarPerfilNome(
                        controladorEditarPerfil: controladorEditarPerfil,
                        controladorPegarUsuario: controladorPegarUsuarioAtual,
                      ),
                      const SizedBox(height: 8),
                      PaginaEditarPerfilGenero(
                        controladorEditarPerfil: controladorEditarPerfil,
                        controladorPegarUsuario: controladorPegarUsuarioAtual,
                      ),
                      const SizedBox(height: 8),
                      PaginaEditarPerfilNascimento(
                        controladorEditarPerfil: controladorEditarPerfil,
                        controladorPegarUsuario: controladorPegarUsuarioAtual,
                      ),
                      const SizedBox(height: 8),
                      PaginaEditarPerfilFoto(
                        controladorEditarPerfil: controladorEditarPerfil,
                        controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
                      ),
                      const SizedBox(height: 8),
                      PaginaEditarBotaoEditar(
                        controlador: controladorEditarPerfil,
                        controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Visibility(
                      visible: controladorEditarPerfil.carregando,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: PaginaEditarBotaoExcluir(
          controladorPerfilControlador: controladorEditarPerfil,
          controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
        ),
      ),
    );
  }
}
