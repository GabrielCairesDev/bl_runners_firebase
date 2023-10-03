import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controller/pagina_concluir_cadastro_controlador.dart';

class PaginaConcluirBotaoConcluir extends StatelessWidget {
  const PaginaConcluirBotaoConcluir({super.key, required this.controladorConcluirCadastro});

  final PaginaConcluirCadastroControlador controladorConcluirCadastro;

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
        .concluirCadastro()
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
    logger.d(onError);
  }
}
