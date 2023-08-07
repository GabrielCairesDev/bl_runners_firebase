import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_entrar_controlador.dart';

class PaginaEntrarCampoSenha extends StatefulWidget {
  const PaginaEntrarCampoSenha({super.key});

  @override
  State<PaginaEntrarCampoSenha> createState() => _PaginaEntrarCampoSenhaState();
}

class _PaginaEntrarCampoSenhaState extends State<PaginaEntrarCampoSenha> {
  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaEntrarControlador>();
    return Form(
      key: controlador.globalKeySenha,
      child: TextFormField(
        controller: controlador.controladorSenha,
        validator: controlador.validadorSenha,
        obscureText: controlador.esconderSenha,
        decoration: InputDecoration(
          hintText: 'Digite a sua senha',
          labelText: 'Senha',
          prefixIcon: const Icon(Icons.key),
          suffixIcon: InkWell(
            onTap: () => setState(
                () => controlador.esconderSenha = !controlador.esconderSenha),
            child: Icon(controlador.esconderSenha
                ? Icons.visibility_off
                : Icons.visibility),
          ),
        ),
      ),
    );
  }
}
