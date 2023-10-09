import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaRegistrarBotaoSalvar extends StatelessWidget {
  const PaginaRegistrarBotaoSalvar({
    super.key,
    required this.controladorPaginaRegistrarAtividade,
    required this.controladorPegarUsuarioAtual,
    required this.controladorPaginaInicio,
  });

  final PaginaRegistrarAtividadeControlador controladorPaginaRegistrarAtividade;
  final PegarUsuarioAtual controladorPegarUsuarioAtual;
  final PaginaInicioControlador controladorPaginaInicio;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _verificarCadastroConcluido(context),
      icon: const Icon(Icons.save),
    );
  }

  _verificarCadastroConcluido(BuildContext context) {
    if (controladorPegarUsuarioAtual.usuarioAtual?.cadastroConcluido != true) {
      Mensagens.mensagemInfo(context, texto: 'Conclua o seu cadastro!');
      context.push(Rotas.concluir);
    } else {
      _registrarAtividade(context);
    }
  }

  _registrarAtividade(BuildContext context) async {
    FocusScope.of(context).unfocus();

    await controladorPaginaRegistrarAtividade
        .registrarAtividade(idUsuario: controladorPegarUsuarioAtual.usuarioAtual?.id)
        .then((value) => _registrarAtividadeSucesso(context, value))
        .catchError((onError) => _registrarAtividadeErro(context, onError));
  }

  _registrarAtividadeSucesso(BuildContext context, value) {
    context.pop();
    Mensagens.mensagemSucesso(context, texto: value);
    controladorPaginaInicio.carregarAtividades();
    logger.d(value);
  }

  _registrarAtividadeErro(BuildContext context, onError) {
    Mensagens.mensagemErro(context, texto: onError);
    logger.d(onError);
  }
}
