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
    final controlador = context.read<PaginaRegistrarControlador>();
    return TextFormField(
      controller: controlador.controladorCnfirmarSenha,
      validator: controlador.validadorConfirmarSenha,
      obscureText: controlador.esconderSenha2,
      decoration: InputDecoration(
        hintText: 'Confirme a sua senha',
        labelText: 'Confirmar senha',
        prefixIcon: const Icon(Icons.key),
        suffixIcon: InkWell(
          onTap: () => setState(() => controlador.esconderSenha2 = !controlador.esconderSenha2),
          child: Icon(controlador.esconderSenha2 ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
