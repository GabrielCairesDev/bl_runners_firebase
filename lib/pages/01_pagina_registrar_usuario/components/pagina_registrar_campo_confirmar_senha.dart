import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoConfirmarSenha extends StatefulWidget {
  const PaginaRegistrarCampoConfirmarSenha({super.key});

  @override
  State<PaginaRegistrarCampoConfirmarSenha> createState() => _PaginaRegistrarCampoConfirmarSenhaState();
}

class _PaginaRegistrarCampoConfirmarSenhaState extends State<PaginaRegistrarCampoConfirmarSenha> {
  @override
  Widget build(BuildContext context) {
    final controladorPaginaRegistrar = context.read<PaginaRegistrarControlador>();
    return TextFormField(
      controller: controladorPaginaRegistrar.controladorCnfirmarSenha,
      validator: controladorPaginaRegistrar.validadorConfirmarSenha,
      obscureText: controladorPaginaRegistrar.esconderSenha2,
      decoration: InputDecoration(
        hintText: 'Confirme a sua senha',
        labelText: 'Confirmar senha',
        prefixIcon: const Icon(Icons.key),
        suffixIcon: InkWell(
          onTap: () => setState(() => controladorPaginaRegistrar.esconderSenha2 = !controladorPaginaRegistrar.esconderSenha2),
          child: Icon(controladorPaginaRegistrar.esconderSenha2 ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
