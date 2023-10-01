import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarBotaoEditar extends StatelessWidget {
  const PaginaEditarBotaoEditar({super.key});

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
      onPressedSim: () {
        Navigator.of(context).pop();
        _editarPerfil(context);
      },
      onPressedNao: () => Navigator.of(context).pop(),
    );
  }

  _editarPerfil(BuildContext context) {
    final controladorPaginaEditarPerfilControlador = context.read<PaginaEditarPerfilControlador>();
    controladorPaginaEditarPerfilControlador.validarCampos().then((value) {
      context.pop();
      controladorPaginaEditarPerfilControlador.alterarEstadoCarregando();
      Mensagens.mensagemSucesso(context, texto: value);
    }).catchError((onError) {
      controladorPaginaEditarPerfilControlador.alterarEstadoCarregando();
      Mensagens.mensagemErro(context, texto: onError);
    });
  }
}
