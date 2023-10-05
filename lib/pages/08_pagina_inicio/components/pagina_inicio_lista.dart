import 'package:bl_runners_firebase/extensions/data_formatada_exetension.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_lista_components/botao_excluir.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_lista_components/data.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_lista_components/distancia.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_lista_components/foto.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_lista_components/nome.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_lista_components/ritmo.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/components/pagina_inicio_lista_components/tipo.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:flutter/material.dart';

class PaginaInicioLista extends StatefulWidget {
  const PaginaInicioLista({super.key, required this.controladorPaginaInicial, required this.controladorPegarUsuarioAtual});

  final PegarUsuarioAtual controladorPegarUsuarioAtual;
  final PaginaInicioControlador controladorPaginaInicial;

  @override
  State<PaginaInicioLista> createState() => _PaginaInicioListaState();
}

class _PaginaInicioListaState extends State<PaginaInicioLista> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.controladorPaginaInicial.carregarAtividades,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.controladorPaginaInicial.listaAtividades.length,
        itemBuilder: (context, index) {
          widget.controladorPaginaInicial.listaAtividades.sort((atividade1, atividade2) {
            return atividade2.dataAtividade.compareTo(atividade1.dataAtividade);
          });

          final atividade = widget.controladorPaginaInicial.listaAtividades[index];
          final usuarioLista = widget.controladorPaginaInicial.listaUsuarios.where((usuario) => usuario.id == atividade.idUsuario).first;

          DateTime data = atividade.dataAtividade;
          String dataFormatada = data.dataFormatada;

          return lista(
            index,
            genero: usuarioLista.genero,
            dataFormatada: dataFormatada,
            usuarioListaID: usuarioLista.id,
            usuarioAtualID: widget.controladorPegarUsuarioAtual.usuarioAtual!.id,
            foto: usuarioLista.fotoUrl,
            nome: usuarioLista.nome,
            tipo: atividade.tipo,
            distancia: atividade.distancia,
            tempo: atividade.tempo,
          );
        },
      ),
    );
  }

  Widget lista(
    int index, {
    required String genero,
    required String dataFormatada,
    required String usuarioListaID,
    required String usuarioAtualID,
    required String foto,
    required String nome,
    required String tipo,
    required int distancia,
    required int tempo,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 6, left: 8, top: 8),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // FUNDO ROZA OU AZUL
          Container(
            height: MediaQuery.of(context).size.height * 0.14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: genero == 'Masculino' ? Colors.blue : Colors.pink,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 0),
                  blurRadius: 5,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // DATA
                  ListaData(data: dataFormatada),
                  // BOTAO
                  ListaBotaoExcluir(
                    usuarioAtualID: usuarioAtualID,
                    usuarioListaID: usuarioListaID,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => const {},
            child: Stack(
              children: [
                // FUNDO BRANCO //
                Container(
                  height: MediaQuery.of(context).size.height * 0.115,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 0),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FOTO
                        ListaFoto(foto: foto),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width * 0.72,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // NOME
                                    ListaNome(nome: nome),
                                    // TIPO
                                    ListaTipo(tipo: tipo),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // DISTÂNCIA
                                    ListaDistancia(distancia: distancia),
                                    // RITMO
                                    ListaRitmo(ritmo: widget.controladorPaginaInicial.calcularRitmo(distancia, tempo)),
                                    // TEMPO
                                    ListaRitmo(ritmo: widget.controladorPaginaInicial.formatarTempo(tempo)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
