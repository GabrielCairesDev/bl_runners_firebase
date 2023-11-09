import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_app/routes/rotas.dart';
import 'package:bl_runners_app/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaPerfilBotaoEditar extends StatelessWidget {
  const PaginaPerfilBotaoEditar(
      {super.key, required this.controladorPegarUsuario});

  final PegarUsuarioAtual controladorPegarUsuario;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (controladorPegarUsuario.usuarioAtual?.cadastroConcluido != true) {
          Mensagens.mensagemInfo(context, texto: 'Conclua o seu cadastro!');
          context.push(Rotas.concluirCadastro);
        } else {
          context.push(Rotas.editarPerfil);
        }
      },
      child: const Icon(Icons.edit),
    );
  }
}
