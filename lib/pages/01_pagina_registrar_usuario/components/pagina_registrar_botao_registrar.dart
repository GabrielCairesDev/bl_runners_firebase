import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarBotaoRegistrar extends StatelessWidget {
  const PaginaRegistrarBotaoRegistrar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _registrarUsuario(context),
        child: const Text('Registrar'),
      ),
    );
  }

  _registrarUsuario(BuildContext context) {
    final controladorPaginaRegistrarUsuario = context.read<PaginaRegistrarUsuarioControlador>();
    FocusScope.of(context).unfocus();
    controladorPaginaRegistrarUsuario.registrarUsuario().then((value) {
      context.pop();
      controladorPaginaRegistrarUsuario.resetarValores();
      controladorPaginaRegistrarUsuario.atualizarCarregando();
      Mensagens.mensagemSucesso(context, texto: value.toString());
    }).catchError(
      (onError) {
        controladorPaginaRegistrarUsuario.atualizarCarregando();
        Mensagens.mensagemErro(context, texto: onError.toString());
      },
    );
  }
}
