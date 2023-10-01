import 'package:bl_runners_firebase/widgets/mensagens.dart';
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

  _registrarUsuario(BuildContext context) {
    FocusScope.of(context).unfocus();
    controlador
        .registrarUsuario()
        .then((value) => _registrarUsuarioSucesso(context, value: value))
        .catchError((onError) => _registrarUsuarioErro(context, onError: onError));
  }

  _registrarUsuarioSucesso(BuildContext context, {required value}) {
    context.pop();
    Mensagens.mensagemSucesso(context, texto: value);
  }

  _registrarUsuarioErro(BuildContext context, {required onError}) {
    Mensagens.mensagemErro(context, texto: onError);
  }
}
