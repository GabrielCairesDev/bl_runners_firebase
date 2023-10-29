import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarBotaoExcluir extends StatelessWidget {
  const PaginaEditarBotaoExcluir({
    super.key,
    required this.controladorPerfilControlador,
    required this.controladorPegarUsuarioAtual,
  });

  final PaginaEditarPerfilControlador controladorPerfilControlador;
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
      escrever: controladorPerfilControlador.controladorSenha,
      titulo: 'Excluir Perfil?',
      textoBotaoExcluir: 'Excluir',
      textoBotaoCancelar: 'Cancelar',
      onPressedExcluir: () => _excluirConta(context),
      onPressedCancelar: () => context.pop(),
    );
  }

  _excluirConta(BuildContext context) async {
    context.pop();
    await controladorPerfilControlador
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
