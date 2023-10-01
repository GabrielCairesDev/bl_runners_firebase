import 'package:flutter/material.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoConfirmarSenha extends StatefulWidget {
  const PaginaRegistrarCampoConfirmarSenha({super.key, required this.controlador});

  final PaginaRegistrarUsuarioControlador controlador;

  @override
  State<PaginaRegistrarCampoConfirmarSenha> createState() => _PaginaRegistrarCampoConfirmarSenhaState();
}

class _PaginaRegistrarCampoConfirmarSenhaState extends State<PaginaRegistrarCampoConfirmarSenha> {
  bool esconderSenha = true;

  @override
  void initState() {
    esconderSenha = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controlador.controladorCnfirmarSenha,
      validator: widget.controlador.validadorConfirmarSenha,
      obscureText: esconderSenha,
      decoration: InputDecoration(
        hintText: 'Confirme a sua senha',
        labelText: 'Confirmar senha',
        prefixIcon: const Icon(Icons.key),
        suffixIcon: InkWell(
          onTap: () => setState(() => esconderSenha = !esconderSenha),
          child: Icon(esconderSenha ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
