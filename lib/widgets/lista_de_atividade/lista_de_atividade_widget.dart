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
    required this.mostrarBotaoExlcuir,
    required this.listasSomadas,
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

  final bool mostrarBotaoExlcuir;
  final bool listasSomadas;
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
        itemCount: widget.listaDeAtividades.isNotEmpty ? widget.listaDeAtividades.length : 0,
        itemBuilder: (context, index) {
          final atividadeLista = widget.listaDeAtividades[index];
          final usuarioLista = widget.listaDeUsuarios.where((usuario) => usuario.id == atividadeLista.idUsuario).first;

          DateTime data = atividadeLista.dataAtividade;
          String dataExtenso = data.diaMesAnoHoraPorExetenso;

          return Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                // FUNDO ROZA OU AZUL
                Container(
                  height: MediaQuery.of(context).size.height * 0.155,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: usuarioLista.genero == 'Masculino' ? Colors.blue : Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 0),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6, top: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // DATA OU POSIÇÃO
                        widget.listasSomadas == true
                            ? ListaAtividadePosicao(
                                index: index,
                                mes: widget.mesFiltro,
                                ano: widget.anoFiltro,
                              )
                            : ListaDeAtividadeDataExtenso(data: dataExtenso),
                        // BOTAO EXCLUIR
                        Visibility(
                          visible: widget.mostrarBotaoExlcuir,
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
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // FOTO DO PERFIL
                            ListaDeAtividadeFotoPerfil(foto: usuarioLista.fotoUrl),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
                                        widget.listasSomadas == true
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
