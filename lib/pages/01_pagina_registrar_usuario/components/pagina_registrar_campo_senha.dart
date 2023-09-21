import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoSenha extends StatefulWidget {
  const PaginaRegistrarCampoSenha({super.key});

  @override
  State<PaginaRegistrarCampoSenha> createState() => _PaginaRegistrarCampoSenhaState();
}

class _PaginaRegistrarCampoSenhaState extends State<PaginaRegistrarCampoSenha> {
  @override
  Widget build(BuildContext context) {
    final controladorPaginaRegistrar = context.read<PaginaRegistrarUsuarioControlador>();
    return TextFormField(
      controller: controladorPaginaRegistrar.controladorSenha,
      validator: controladorPaginaRegistrar.validadorSenha,
      obscureText: controladorPaginaRegistrar.esconderSenha,
      decoration: InputDecoration(
        hintText: 'Digite a sua senha',
        labelText: 'Senha',
        prefixIcon: const Icon(Icons.key),
        suffixIcon: InkWell(
          onTap: () => setState(() => controladorPaginaRegistrar.esconderSenha = !controladorPaginaRegistrar.esconderSenha),
          child: Icon(controladorPaginaRegistrar.esconderSenha ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
