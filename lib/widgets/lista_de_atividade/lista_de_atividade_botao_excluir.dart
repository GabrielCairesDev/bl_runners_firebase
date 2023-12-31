import 'package:bl_runners_app/main.dart';
import 'package:bl_runners_app/pages/f_pagina_perfil/controller/pagina_perfil_controlador.dart';
import 'package:bl_runners_app/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListaDeAtividadeBotaoExcluir extends StatefulWidget {
  const ListaDeAtividadeBotaoExcluir({
    super.key,
    required this.usuarioListaID,
    required this.usuarioAtualID,
    required this.atividadeListaID,
  });

  final String usuarioListaID;
  final String usuarioAtualID;
  final String atividadeListaID;

  @override
  State<ListaDeAtividadeBotaoExcluir> createState() =>
      _ListaDeAtividadeBotaoExcluirState();
}

class _ListaDeAtividadeBotaoExcluirState
    extends State<ListaDeAtividadeBotaoExcluir> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.usuarioListaID == widget.usuarioAtualID
            ? InkWell(
                onTap: () => _caixaConfirmar(context),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 20,
                ),
              )
            : const SizedBox(width: 20),
        const SizedBox(width: 6)
      ],
    );
  }

  _caixaConfirmar(BuildContext context) {
    Mensagens.caixaDeDialogoSimNao(
      context,
      titulo: 'Deseja excluir a atividade?',
      texto: 'Esta ação não poderá ser desfeita!',
      textoBotaoNao: 'Não',
      onPressedNao: () => context.pop(),
      textoBotaoSim: 'Sim',
      onPressedSim: () => _excluirAtivdade(context),
    );
  }

  _excluirAtivdade(BuildContext context) async {
    final controlador = context.read<PaginaPerfilControlador>();

    await controlador
        .excluirAtividade(
            listaID: widget.atividadeListaID, idUsuario: widget.usuarioAtualID)
        .then(
          (value) => _excluirAtivdadeSucesso(context, value),
        )
        .catchError(
          (onError) => _excluirAtivdadeErro(context, onError),
        );
  }

  _excluirAtivdadeSucesso(BuildContext context, value) {
    context.pop();
    Mensagens.mensagemSucesso(context, texto: value);
    logger.d(value);
  }

  _excluirAtivdadeErro(BuildContext context, onError) {
    context.pop();
    Mensagens.mensagemErro(context, texto: onError);
    logger.e(onError);
  }
}
