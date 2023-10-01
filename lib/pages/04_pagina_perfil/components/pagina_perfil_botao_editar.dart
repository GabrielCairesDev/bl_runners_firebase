import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PaginaPerfilBotaoEditar extends StatelessWidget {
  const PaginaPerfilBotaoEditar({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorDataProvider = Provider.of<PegarUsuario>(context);
    return FloatingActionButton(
      onPressed: () {
        if (controladorDataProvider.modeloUsuario?.cadastroConcluido != true) {
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
