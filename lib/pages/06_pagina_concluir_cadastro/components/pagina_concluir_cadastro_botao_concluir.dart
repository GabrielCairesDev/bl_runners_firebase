import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_concluir_cadastro_controlador.dart';

class PaginaConcluirBotaoConcluir extends StatelessWidget {
  const PaginaConcluirBotaoConcluir({super.key});

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
    final controladorPaginaConcluirControlador = context.read<PaginaConcluirCadastroControlador>();

    await controladorPaginaConcluirControlador.concluirCadastro().then((value) {
      context.pop();
      controladorPaginaConcluirControlador.alterarEstadoCarregando();
      Mensagens.mensagemSucesso(context, texto: value);
    }).catchError(
      (onError) {
        controladorPaginaConcluirControlador.alterarEstadoCarregando();
        Mensagens.mensagemErro(context, texto: onError.toString());
      },
    );
  }
}
