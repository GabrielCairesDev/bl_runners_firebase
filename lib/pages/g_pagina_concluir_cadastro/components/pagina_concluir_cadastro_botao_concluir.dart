import 'package:bl_runners_app/main.dart';
import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_app/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controller/pagina_concluir_cadastro_controlador.dart';

class PaginaConcluirBotaoConcluir extends StatelessWidget {
  const PaginaConcluirBotaoConcluir({
    super.key,
    required this.controladorConcluirCadastro,
    required this.controladorPegarUsuario,
  });

  final PaginaConcluirCadastroControlador controladorConcluirCadastro;
  final PegarUsuarioAtual controladorPegarUsuario;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 1.0,
      child: ElevatedButton(
        onPressed: () => _concluirCadastro(context),
        child: const Text('Concluir'),
      ),
    );
  }

  _concluirCadastro(BuildContext context) async {
    await controladorConcluirCadastro
        .concluirCadastro(
            usuarioAutorizado:
                controladorPegarUsuario.usuarioAtual?.autorizado ?? false)
        .then((value) => _concluirCadastroSucesso(context, value))
        .catchError((onError) => _concluirCadastroErro(context, onError));
  }

  _concluirCadastroSucesso(BuildContext context, value) {
    context.pop();
    Mensagens.mensagemSucesso(context, texto: value);
    logger.d(value);
  }

  _concluirCadastroErro(BuildContext context, onError) {
    Mensagens.mensagemErro(context, texto: onError.toString());
    logger.e(onError);
  }
}
