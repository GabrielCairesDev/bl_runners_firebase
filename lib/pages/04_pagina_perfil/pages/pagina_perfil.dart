import 'package:bl_runners_firebase/pages/04_pagina_perfil/components/pagina_perfil_botao_admin.dart';
import 'package:bl_runners_firebase/pages/04_pagina_perfil/components/pagina_perfil_botao_editar.dart';
import 'package:bl_runners_firebase/pages/04_pagina_perfil/components/pagina_perfil_botao_sair.dart';
import 'package:bl_runners_firebase/pages/04_pagina_perfil/controller/pagina_perfil_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/pagina_perfil_avatar.dart';
import '../components/pagina_perfil_nome.dart';
import '../components/pagina_perfil_recordes.dart';

class PaginaPerfil extends StatefulWidget {
  const PaginaPerfil({super.key});

  @override
  State<PaginaPerfil> createState() => _PaginaPerfilState();
}

class _PaginaPerfilState extends State<PaginaPerfil> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controladorPaginaPerfil = context.read<PaginaPerfilControlador>();
      final controladorPegarUsuarioAtual = context.read<PegarUsuarioAtual>();
      controladorPaginaPerfil.idUsuario = controladorPegarUsuarioAtual.usuarioAtual?.id ?? '';
      controladorPaginaPerfil.carregarAtividades();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controladorPaginaPerfil = Provider.of<PaginaPerfilControlador>(context);
    final controladorPegarUsuarioAtual = Provider.of<PegarUsuarioAtual>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Perfil'),
        leading: const PaginaPerfilBotaoSair(),
        actions: [
          PaginaEditarBotaoSair(controlador: controladorPaginaPerfil),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.95,
              width: double.infinity,
              color: const Color(0xFFc1d22b),
            ),
            Column(
              children: [
                const SizedBox(height: 88),
                PaginaPerfilAvatar(controladorPegarUsuario: controladorPegarUsuarioAtual),
                const SizedBox(height: 8),
                PaginaPerfilNome(controladorPegarUsuario: controladorPegarUsuarioAtual),
                const SizedBox(height: 8),
                PaginaPerfilRecordes(controladorPaginaPerfil: controladorPaginaPerfil),
                RefreshIndicator(
                  onRefresh: controladorPaginaPerfil.carregarAtividades,
                  child: Column(
                    children: [
                      ListaDeAtividadeWidget(
                        controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
                        mostrarBotaoExlcuir: true,
                        paginaPerfil: true,
                        listasSomadas: false,
                        carregarAtividades: controladorPaginaPerfil.carregarAtividades,
                        listaDeAtividades: controladorPaginaPerfil.listaDeAtividades,
                        listaDeUsuarios: controladorPaginaPerfil.listaDeUsuarios,
                        anoFiltro: 0,
                        mesFiltro: 0,
                        idUsuario: controladorPegarUsuarioAtual.usuarioAtual!.id,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: PaginaPerfilBotaoEditar(controladorPegarUsuario: controladorPegarUsuarioAtual),
    );
  }
}
