import 'package:bl_runners_firebase/providers/pegar_usuario.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PaginaInicioBotaoAdd extends StatelessWidget {
  const PaginaInicioBotaoAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorDataProvider = Provider.of<PegarUsuario>(context);
    return FloatingActionButton(
      onPressed: () {
        if (controladorDataProvider.modeloUsuario?.cadastroConcluido != true) {
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
