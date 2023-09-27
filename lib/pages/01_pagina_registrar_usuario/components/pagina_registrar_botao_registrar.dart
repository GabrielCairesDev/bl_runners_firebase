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
        onPressed: () => _registarUsuario(context),
        child: const Text('Registrar'),
      ),
    );
  }

  _registarUsuario(BuildContext context) {
    final controladorPaginaRegistrarUsuario = context.read<PaginaRegistrarUsuarioControlador>();
    controladorPaginaRegistrarUsuario.atualizarCarregando();
    controladorPaginaRegistrarUsuario.registrarUsuario().then((value) {
      if (value) {
        Mensagens.mensagemSucesso(context, texto: 'Usuário registrado com sucesso!');

        controladorPaginaRegistrarUsuario.resetarValores();
        context.pop();
      } else {
        Mensagens.mensagemErro(context, texto: 'Algo deu errado');
      }
      controladorPaginaRegistrarUsuario.atualizarCarregando();
    });
  }
}
