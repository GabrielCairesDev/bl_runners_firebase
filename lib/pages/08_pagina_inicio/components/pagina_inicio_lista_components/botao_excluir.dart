import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListaBotaoExcluir extends StatelessWidget {
  const ListaBotaoExcluir({super.key, required this.usuarioListaID, required this.usuarioAtualID});

  final String usuarioListaID;
  final String usuarioAtualID;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        usuarioListaID == usuarioAtualID
            ? InkWell(
                onTap: () => _pedirSenha(context),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 20,
                ),
              )
            : const SizedBox(width: 20), // Substituí null por SizedBox com largura 20 para evitar erro de layout
        const SizedBox(width: 6)
      ],
    );
  }

  _pedirSenha(BuildContext context) {
    Mensagens.caixaDeDialogoSimNao(
      context,
      titulo: 'Deseja excluir a atividade?',
      texto: 'Esta ação não poderá ser desfeita!',
      textoBotaoNao: 'Não',
      onPressedNao: () => context.pop(),
      textoBotaoSim: 'Sim',
      onPressedSim: () => context.pop(),
    );
  }
}
