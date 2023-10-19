import 'package:bl_runners_firebase/pages/13_pagina_admin/controller/pagina_admin_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_foto.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_infos.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_nome.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_switch_admin.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_switch_autorizado.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_switch_master.dart';
import 'package:flutter/material.dart';

class ListaDeUsuariosWidgets extends StatelessWidget {
  const ListaDeUsuariosWidgets({super.key, required this.controladorPaginaAdmin, required this.controladorPegarUsuarioAtual});

  final PaginaAdminControlador controladorPaginaAdmin;
  final PegarUsuarioAtual controladorPegarUsuarioAtual;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controladorPaginaAdmin.listaDeUsuariosFiltro.isEmpty ? 0 : controladorPaginaAdmin.listaDeUsuariosFiltro.length,
      itemBuilder: (context, index) {
        final usuario = controladorPaginaAdmin.listaDeUsuariosFiltro[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          // FUNDO AZUL OU ROSA
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.155,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: usuario.genero == 'Masculino' ? Colors.blue : Colors.pink,
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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  // NOME E NASCIMENTO
                  child: ListaDeUsuariosNome(
                    dataAniversario: usuario.dataNascimento,
                    nome: usuario.nome,
                  ),
                ),
              ),
              // FUNDO BRANCO
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // FOTO DE PERFIL
                        const ListaDeUsuariosFoto(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ListaDeUsuariosInfos(
                                  cadastroConcluido: usuario.cadastroConcluido,
                                  email: usuario.email,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ListaDeUsuariosSwitchMaster(
                                      idUsuario: usuario.id,
                                      controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
                                      master: usuario.master,
                                      controladorPaginaAdmin: controladorPaginaAdmin,
                                    ),
                                    ListaDeUsuariosSwitchAdmin(
                                      admin: usuario.admin,
                                      idUsuario: usuario.id,
                                      controladorPaginaAdmin: controladorPaginaAdmin,
                                      controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
                                    ),
                                    ListaDeUsuariosSwitchAutorizado(
                                      autorizado: usuario.autorizado,
                                      idUsuario: usuario.id,
                                      controladorPaginaAdmin: controladorPaginaAdmin,
                                      controladorPegarUsuarioAtual: controladorPegarUsuarioAtual,
                                    ),
                                  ],
                                )
                                // ListaDeUsuariosSwitches(
                                //   admin: usuario.admin,
                                //   autorizado: usuario.autorizado,
                                //   master: usuario.master,
                                //   idUsuario: usuario.id,
                                //   controlador: controlador,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
