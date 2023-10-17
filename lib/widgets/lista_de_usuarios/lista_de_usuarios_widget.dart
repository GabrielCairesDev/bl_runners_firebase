import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_foto.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_infos.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_nome.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_switches.dart';
import 'package:flutter/material.dart';

class ListaDeUsuariosWidgets extends StatelessWidget {
  const ListaDeUsuariosWidgets({
    super.key,
    required this.listaDeUsuariosFiltro,
  });

  final List<ModeloDeUsuario> listaDeUsuariosFiltro;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaDeUsuariosFiltro.isEmpty ? 0 : listaDeUsuariosFiltro.length,
      itemBuilder: (context, index) {
        final usuario = listaDeUsuariosFiltro[index];

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
                                ListaDeUsuariosSwitches(
                                  master: usuario.master,
                                  admin: usuario.admin,
                                  autorizado: usuario.autorizado,
                                ),
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
