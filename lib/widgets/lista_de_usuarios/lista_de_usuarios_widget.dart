import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_foto.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_infos.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_nome.dart';
import 'package:bl_runners_firebase/widgets/lista_de_usuarios/lista_de_usuarios_switches.dart';
import 'package:flutter/material.dart';

class ListaDeUsuariosWidgets extends StatelessWidget {
  const ListaDeUsuariosWidgets({super.key, required this.listaDeUsuarios});

  final List<ModeloDeUsuario> listaDeUsuarios;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaDeUsuarios.isEmpty ? 0 : listaDeUsuarios.length,
      itemBuilder: (context, index) {
        final usuario = listaDeUsuarios[index];

        return Padding(
          padding: const EdgeInsets.all(8),
          // FUNDO AZUL OU ROSA
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.14,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: usuario.genero == 'Masculino' ? Colors.blue : Colors.pink,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 0),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  // NOME E NNASCIMENTO
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
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 0),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                                ListaDeUsuariosInfos(cadastroConcluido: usuario.cadastroConcluido, email: usuario.email),
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
