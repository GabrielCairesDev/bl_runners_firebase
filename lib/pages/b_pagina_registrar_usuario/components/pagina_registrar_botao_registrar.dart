import 'package:bl_runners_app/main.dart';
import 'package:bl_runners_app/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarBotaoRegistrar extends StatelessWidget {
  const PaginaRegistrarBotaoRegistrar({super.key, required this.controlador});

  final PaginaRegistrarUsuarioControlador controlador;

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

  _registrarUsuario(BuildContext context) async {
    FocusScope.of(context).unfocus();
    await controlador
        .registrarUsuario()
        .then((value) => _registrarUsuarioSucesso(context, value))
        .catchError((onError) => _registrarUsuarioErro(context, onError));
  }

  _registrarUsuarioSucesso(BuildContext context, value) {
    context.pop();
    Mensagens.mensagemSucesso(context, texto: value);
    logger.d(value);
  }

  _registrarUsuarioErro(BuildContext context, onError) {
    Mensagens.mensagemErro(context, texto: onError);
    logger.e(onError);
  }
}
