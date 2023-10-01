import 'package:flutter/material.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoSenha extends StatefulWidget {
  const PaginaRegistrarCampoSenha({super.key, required this.controlador});

  final PaginaRegistrarUsuarioControlador controlador;

  @override
  State<PaginaRegistrarCampoSenha> createState() => _PaginaRegistrarCampoSenhaState();
}

class _PaginaRegistrarCampoSenhaState extends State<PaginaRegistrarCampoSenha> {
  bool esconderSenha = true;

  @override
  void initState() {
    esconderSenha = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controlador.controladorSenha,
      validator: widget.controlador.validadorSenha,
      obscureText: esconderSenha,
      decoration: InputDecoration(
        hintText: 'Digite a sua senha',
        labelText: 'Senha',
        prefixIcon: const Icon(Icons.key),
        suffixIcon: InkWell(
          onTap: () => setState(() => esconderSenha = !esconderSenha),
          child: Icon(esconderSenha ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
