import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarLinkExcluir extends StatelessWidget {
  const PaginaEditarLinkExcluir({super.key, required this.controlador});

  final PaginaEditarPerfilControlador controlador;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pedirSenha(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
          child: const Text(
            'Excluir Perfil',
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  _pedirSenha(BuildContext context) {
    Mensagens.caixaDialogoDigitarSenha(
      context,
      escrever: controlador.controladorSenha,
      titulo: 'Excluir Perfil?',
      textoBotaoExcluir: 'Excluir',
      textoBotaoCancelar: 'Cancelar',
      onPressedExcluir: () => _excluirConta(context),
      onPressedCancelar: () => context.pop(),
    );
  }

  _excluirConta(BuildContext context) async {
    await controlador
        .excluirConta()
        .then((value) => _excluirContaSucesso(context, value))
        .catchError((onError) => _excluirContaErro(context, onError));
  }

  _excluirContaSucesso(BuildContext context, value) {
    context.pushReplacement(Rotas.entrar);
    Mensagens.mensagemSucesso(context, texto: value);
    logger.d(value);
  }

  _excluirContaErro(BuildContext context, onError) {
    context.pop();
    Mensagens.mensagemSucesso(context, texto: onError);
    logger.d(onError);
  }
}
