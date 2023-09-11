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
    final controladorPaginaEntrar = context.read<PaginaEntrarControlador>();
    return TextFormField(
      controller: controladorPaginaEntrar.controladorSenha,
      validator: controladorPaginaEntrar.validadorSenha,
      obscureText: controladorPaginaEntrar.esconderSenha,
      decoration: InputDecoration(
        hintText: 'Digite a sua senha',
        labelText: 'Senha',
        prefixIcon: const Icon(Icons.key),
        suffixIcon: InkWell(
          onTap: () => setState(() => controladorPaginaEntrar.esconderSenha = !controladorPaginaEntrar.esconderSenha),
          child: Icon(controladorPaginaEntrar.esconderSenha ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
