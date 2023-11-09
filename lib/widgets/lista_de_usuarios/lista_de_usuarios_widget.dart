import 'package:bl_runners_app/pages/i_pagina_admin/controller/pagina_admin_controlador.dart';
import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_app/widgets/lista_de_usuarios/lista_de_usuarios_foto.dart';
import 'package:bl_runners_app/widgets/lista_de_usuarios/lista_de_usuarios_infos.dart';
import 'package:bl_runners_app/widgets/lista_de_usuarios/lista_de_usuarios_nome.dart';
import 'package:bl_runners_app/widgets/lista_de_usuarios/lista_de_usuarios_switch_admin.dart';
import 'package:bl_runners_app/widgets/lista_de_usuarios/lista_de_usuarios_switch_autorizado.dart';
import 'package:bl_runners_app/widgets/lista_de_usuarios/lista_de_usuarios_switch_master.dart';
import 'package:flutter/material.dart';

class ListaDeUsuariosWidgets extends StatelessWidget {
  const ListaDeUsuariosWidgets({
    super.key,
    required this.controladorPaginaAdmin,
    required this.controladorPegarUsuarioAtual,
  });

  final PaginaAdminControlador controladorPaginaAdmin;
  final PegarUsuarioAtual controladorPegarUsuarioAtual;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controladorPaginaAdmin.carregarUsuarios,
      child: ListView.builder(
        itemCount: controladorPaginaAdmin.listaDeUsuariosFiltro.isEmpty
            ? 0
            : controladorPaginaAdmin.listaDeUsuariosFiltro.length,
        itemBuilder: (context, index) {
          final listaUsuario =
              controladorPaginaAdmin.listaDeUsuariosFiltro[index];
          final usuarioAtual = controladorPegarUsuarioAtual.usuarioAtual;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            // FUNDO AZUL OU ROSA
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: listaUsuario.genero == 'Masculino'
                        ? Colors.blue
                        : Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 0),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    // NOME E NASCIMENTO
                    child: ListaDeUsuariosNome(
                      dataAniversario: listaUsuario.dataNascimento.toDate(),
                      nome: listaUsuario.nome,
                    ),
                  ),
                ),
                // FUNDO BRANCO
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 0),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // FOTO DE PERFIL
                            ListaDeUsuariosFoto(foto: listaUsuario.fotoUrl),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ListaDeUsuariosInfos(
                                      cadastroConcluido:
                                          listaUsuario.cadastroConcluido,
                                      email: listaUsuario.email,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ListaDeUsuariosSwitchMaster(
                                          controladorPaginaAdmin:
                                              controladorPaginaAdmin,
                                          listaUsuarioId: listaUsuario.id,
                                          listaUsuarioCadastroConcluido:
                                              listaUsuario.cadastroConcluido,
                                          listaUsuarioAutorizado:
                                              listaUsuario.autorizado,
                                          listaUsuarioMaster:
                                              listaUsuario.master,
                                          listaUsuarioAdmin: listaUsuario.admin,
                                          usuarioAtualId:
                                              usuarioAtual?.id ?? '',
                                          usuarioAtualAdmin:
                                              usuarioAtual?.admin ?? false,
                                          usuarioAtualAutorizado:
                                              usuarioAtual?.autorizado ?? false,
                                          usuarioAtualMaster:
                                              usuarioAtual?.master ?? false,
                                        ),
                                        ListaDeUsuariosSwitchAdmin(
                                          controladorPaginaAdmin:
                                              controladorPaginaAdmin,
                                          listaUsuarioid: listaUsuario.id,
                                          listaUsuarioCadastroConcluido:
                                              listaUsuario.cadastroConcluido,
                                          listaUsuarioAutorizado:
                                              listaUsuario.autorizado,
                                          listaUsuarioAmin: listaUsuario.admin,
                                          listaUsuarioMaster:
                                              listaUsuario.master,
                                          usuarioAtualId:
                                              usuarioAtual?.id ?? '',
                                          usuarioAtualAdmin:
                                              usuarioAtual?.admin ?? false,
                                          usuarioAtualAutorizado:
                                              usuarioAtual?.autorizado ?? false,
                                          usuarioAtualMaster:
                                              usuarioAtual?.master ?? false,
                                        ),
                                        ListaDeUsuariosSwitchAutorizado(
                                          controladorPaginaAdmin:
                                              controladorPaginaAdmin,
                                          listaUsuarioid: listaUsuario.id,
                                          listaUsuarioAutorizado:
                                              listaUsuario.autorizado,
                                          listaUsuarioAdmin: listaUsuario.admin,
                                          listaUsuarioMaster:
                                              listaUsuario.master,
                                          usuarioAtualId:
                                              usuarioAtual?.id ?? '',
                                          usuarioAtualAdmin:
                                              usuarioAtual?.admin ?? false,
                                          usuarioAtualAutorizado:
                                              usuarioAtual?.autorizado ?? false,
                                          usuarioAtualMaster:
                                              usuarioAtual?.master ?? false,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
