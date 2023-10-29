import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/pages/g_pagina_concluir_cadastro/controller/pagina_concluir_cadastro_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaConcluirCadastroBotaoExcluir extends StatelessWidget {
  const PaginaConcluirCadastroBotaoExcluir({
    super.key,
    required this.controladorPaginaConcluircadastro,
    required this.controladorPegarUsuarioAtual,
  });

  final PaginaConcluirCadastroControlador controladorPaginaConcluircadastro;
  final PegarUsuarioAtual controladorPegarUsuarioAtual;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _pedirSenha(context),
      backgroundColor: Colors.red,
      child: const Icon(
        Icons.delete,
      ),
    );
  }

  _pedirSenha(BuildContext context) {
    Mensagens.caixaDialogoDigitarSenha(
      context,
      escrever: controladorPaginaConcluircadastro.controladorSenha,
      titulo: 'Excluir Perfil?',
      textoBotaoExcluir: 'Excluir',
      textoBotaoCancelar: 'Cancelar',
      onPressedExcluir: () => _excluirConta(context),
      onPressedCancelar: () => context.pop(),
    );
  }

  _excluirConta(BuildContext context) async {
    context.pop();
    await controladorPaginaConcluircadastro
        .excluirConta(idUsuario: controladorPegarUsuarioAtual.usuarioAtual?.id)
        .then((value) => _excluirContaSucesso(context, value))
        .catchError((onError) => _excluirContaErro(context, onError));
  }

  _excluirContaSucesso(BuildContext context, value) {
    context.pushReplacement(Rotas.entrar);
    Mensagens.mensagemSucesso(context, texto: value);
    logger.d(value);
  }

  _excluirContaErro(BuildContext context, onError) {
    Mensagens.mensagemErro(context, texto: onError);
    logger.e(onError);
  }
}
