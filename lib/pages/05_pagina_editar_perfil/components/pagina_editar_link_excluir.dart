import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarLinkExcluir extends StatelessWidget {
  const PaginaEditarLinkExcluir({super.key});

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
    final controladorPaginaEditarPerfil = Provider.of<PaginaEditarPerfilControlador>(context);
    Mensagens.caixaDialogoDigitarSenha(
      context,
      escrever: controladorPaginaEditarPerfil.controladorSenha,
      titulo: 'Excluir Perfil?',
      textoBotaoExcluir: 'Excluir',
      textoBotaoCancelar: 'Cancelar',
      onPressedExcluir: () => _excluirConta(context),
      onPressedCancelar: () => Navigator.of(context).pop(),
    );
  }

  _excluirConta(BuildContext context) {
    final controladorPaginaEditarPerfil = Provider.of<PaginaEditarPerfilControlador>(context);
    controladorPaginaEditarPerfil.excluirConta().then((value) {
      context.pushReplacement(Rotas.entrar);
      controladorPaginaEditarPerfil.alterarEstadoCarregando();
      controladorPaginaEditarPerfil.controladorSenha.clear();
      Mensagens.mensagemSucesso(context, texto: value);
    }).catchError((onError) {
      context.pop();
      controladorPaginaEditarPerfil.alterarEstadoCarregando();
      controladorPaginaEditarPerfil.controladorSenha.clear();
    });
  }
}
