import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarBotaoEditar extends StatelessWidget {
  const PaginaEditarBotaoEditar({super.key, required this.controlador});

  final PaginaEditarPerfilControlador controlador;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 1.0,
      child: ElevatedButton(
        onPressed: () => _perguntar(context),
        child: const Text('Editar'),
      ),
    );
  }

  _perguntar(BuildContext context) {
    Mensagens.caixaDeDialogoSimNao(
      context,
      titulo: 'Atenção!',
      texto: 'Você deseja editar seus dados?',
      textoBotaoSim: 'Sim',
      textoBotaoNao: 'Não',
      onPressedSim: () => _editarPerfil(context),
      onPressedNao: () => Navigator.of(context).pop(),
    );
  }

  _editarPerfil(BuildContext context) async {
    context.pop();
    await controlador
        .editarPerfil()
        .then((value) => _editarPerfilSucesso(context, value))
        .catchError((onError) => _editarPerfilErro(context, onError));
  }

  _editarPerfilSucesso(BuildContext context, value) {
    context.pop();
    logger.d(value);
    Mensagens.mensagemSucesso(context, texto: value);
  }

  _editarPerfilErro(BuildContext context, onError) {
    logger.d(onError);
    Mensagens.mensagemErro(context, texto: onError);
  }
}
