import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaginaInicioBotaoAdd extends StatelessWidget {
  const PaginaInicioBotaoAdd({super.key, required this.controlador});

  final PegarUsuarioAtual controlador;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (controlador.usuarioAtual?.cadastroConcluido != true) {
          Mensagens.mensagemInfo(context, texto: 'Conclua o seu cadastro!');
          context.push(Rotas.concluir);
        } else {
          context.push(Rotas.adicionar);
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
