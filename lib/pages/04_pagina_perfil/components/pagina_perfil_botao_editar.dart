import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaPerfilBotaoEditar extends StatelessWidget {
  const PaginaPerfilBotaoEditar({super.key, required this.controladorPegarUsuario});

  final PegarUsuario controladorPegarUsuario;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (controladorPegarUsuario.modeloUsuario?.cadastroConcluido != true) {
          Mensagens.mensagemInfo(context, texto: 'Conclua o seu cadastro!');
          context.push(Rotas.concluir);
        } else {
          context.push(Rotas.editar);
        }
      },
      child: const Icon(Icons.edit),
    );
  }
}
