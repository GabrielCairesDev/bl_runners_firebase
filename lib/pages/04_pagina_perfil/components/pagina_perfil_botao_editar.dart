import 'package:bl_runners_firebase/providers/data_provider.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PaginaPerfilBotaoEditar extends StatelessWidget {
  const PaginaPerfilBotaoEditar({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorDataProvider = Provider.of<DataProvider>(context);
    return FloatingActionButton(
      onPressed: () {
        // Verificar se é null
        if (controladorDataProvider.modeloUsuario?.cadastroConcluido != true) {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.info(
              backgroundColor: Colors.orange,
              message: 'Conclua o seu cadastro',
            ),
          );
          context.push(Rotas.concluir);
        } else {
          context.push(Rotas.editar);
        }
      },
      child: const Icon(Icons.edit),
    );
  }
}