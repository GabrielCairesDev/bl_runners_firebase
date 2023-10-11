import 'package:bl_runners_firebase/extensions/data_formatada_exetension.dart';
import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/utils/utilitarios.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_botao_excluir.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_data_extenso.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_distancia.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_foto_perfil.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_medalha.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_nome_usuario.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_ritmo.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_tempo.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_posicao.dart';
import 'package:bl_runners_firebase/widgets/lista_de_atividade/lista_de_atividade_tipo_atividade.dart';
import 'package:flutter/material.dart';

class ListaDeAtividadeWidget extends StatefulWidget {
  const ListaDeAtividadeWidget({
    super.key,
    required this.controladorPegarUsuarioAtual,
    required this.paginaInicio,
    required this.paginaDeRanking,
    required this.carregarAtividades,
    required this.listaDeAtividades,
    required this.listaDeUsuarios,
    required this.mesFiltro,
    required this.anoFiltro,
    required this.idUsuario,
    required this.paginaPerfil,
  });

  final PegarUsuarioAtual controladorPegarUsuarioAtual;
  final Future<void> Function() carregarAtividades;

  final bool paginaInicio;
  final bool paginaDeRanking;
  final List<ModeloDeAtividade> listaDeAtividades;
  final List<ModeloDeUsuario> listaDeUsuarios;
  final int mesFiltro;
  final int anoFiltro;
  final String idUsuario;
  final bool paginaPerfil;

  @override
  State<ListaDeAtividadeWidget> createState() => _ListaDeAtividadeWidgetState();
}

class _ListaDeAtividadeWidgetState extends State<ListaDeAtividadeWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.carregarAtividades,
      child: ListView.builder(
        padding: widget.paginaPerfil ? EdgeInsets.zero : null,
        shrinkWrap: true,
        physics: widget.paginaPerfil ? const NeverScrollableScrollPhysics() : null,
        itemCount: widget.listaDeAtividades.length,
        itemBuilder: (context, index) {
          final atividadeLista = widget.listaDeAtividades[index];
          final usuarioLista = widget.listaDeUsuarios.where((usuario) => usuario.id == atividadeLista.idUsuario).first;

          DateTime data = atividadeLista.dataAtividade;
          String dataExtenso = data.diaMesAnoHoraPorExetenso;

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
                    color: usuarioLista.genero == 'Masculino' ? Colors.blue : Colors.pink,
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
                        // DATA OU POSIÇÃO
                        widget.paginaDeRanking == true
                            ? ListaAtividadePosicao(
                                index: index,
                                mes: widget.mesFiltro,
                                ano: widget.anoFiltro,
                              )
                            : ListaDeAtividadeDataExtenso(data: dataExtenso),
                        // BOTAO EXCLUIR
                        Visibility(
                          visible: widget.paginaInicio,
                          child: ListaDeAtividadeBotaoExcluir(
                            usuarioAtualID: widget.controladorPegarUsuarioAtual.usuarioAtual?.id ?? '',
                            usuarioListaID: usuarioLista.id,
                            atividadeListaID: atividadeLista.idAtividade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
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
                            // FOTO DO PERFIL
                            ListaDeAtividadeFotoPerfil(foto: usuarioLista.fotoUrl),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.11,
                              width: MediaQuery.of(context).size.width * 0.72,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // NOME DO USUÁRIO
                                        ListaAtividadeNomeUsuario(nome: usuarioLista.nome),
                                        // TIPO DE ATIVIDADE OU MEDALHA
                                        widget.paginaDeRanking == true
                                            ? ListaDeAtividadeMedalha(index: index)
                                            : ListaDeAtividadeTipoAtividade(tipo: atividadeLista.tipo),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // DISTÂNCIA
                                        ListaDeAtividadeDistancia(distancia: atividadeLista.distancia),
                                        // RITMO
                                        ListaDeAtividadeRitmo(
                                            ritmo: Utilidarios().calcularRitmo(atividadeLista.distancia, atividadeLista.tempo)),
                                        // TEMPO
                                        ListaDeAtivdadeTempo(tempo: Utilidarios().formatarTempo(atividadeLista.tempo)),
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
