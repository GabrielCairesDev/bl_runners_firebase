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
    final controlador = context.read<PaginaRegistrarControlador>();
    return TextFormField(
      controller: controlador.controladorSenha,
      validator: controlador.validadorSenha,
      obscureText: controlador.esconderSenha,
      decoration: InputDecoration(
        hintText: 'Digite a sua senha',
        labelText: 'Senha',
        prefixIcon: const Icon(Icons.key),
        suffixIcon: InkWell(
          onTap: () => setState(() => controlador.esconderSenha = !controlador.esconderSenha),
          child: Icon(controlador.esconderSenha ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
