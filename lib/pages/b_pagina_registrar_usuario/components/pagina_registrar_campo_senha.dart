import 'package:bl_runners_app/utils/validadores.dart';
import 'package:flutter/material.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoSenha extends StatefulWidget {
  const PaginaRegistrarCampoSenha({super.key, required this.controlador});

  final PaginaRegistrarUsuarioControlador controlador;

  @override
  State<PaginaRegistrarCampoSenha> createState() =>
      _PaginaRegistrarCampoSenhaState();
}

class _PaginaRegistrarCampoSenhaState extends State<PaginaRegistrarCampoSenha> {
  bool _esconderSenha = true;

  @override
  void initState() {
    super.initState();
    _esconderSenha = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controlador.controladorSenha,
      validator: Validador.senha,
      obscureText: _esconderSenha,
      decoration: InputDecoration(
        hintText: 'Digite a sua senha',
        labelText: 'Senha',
        prefixIcon: const Icon(Icons.key),
        suffixIcon: InkWell(
          onTap: () => setState(() => _esconderSenha = !_esconderSenha),
          child: Icon(_esconderSenha ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
