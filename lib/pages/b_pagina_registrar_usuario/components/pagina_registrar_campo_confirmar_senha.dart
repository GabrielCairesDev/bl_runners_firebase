import 'package:flutter/material.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoConfirmarSenha extends StatefulWidget {
  const PaginaRegistrarCampoConfirmarSenha({super.key, required this.controlador});

  final PaginaRegistrarUsuarioControlador controlador;

  @override
  State<PaginaRegistrarCampoConfirmarSenha> createState() => _PaginaRegistrarCampoConfirmarSenhaState();
}

class _PaginaRegistrarCampoConfirmarSenhaState extends State<PaginaRegistrarCampoConfirmarSenha> {
  bool _esconderSenha = true;

  @override
  void initState() {
    super.initState();
    _esconderSenha = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controlador.controladorConfirmarSenha,
      validator: (value) {
        if (widget.controlador.controladorSenha.text.toString() != value.toString()) {
          return 'Senhas não conferem';
        }
        return null;
      },
      obscureText: _esconderSenha,
      decoration: InputDecoration(
        hintText: 'Confirme a sua senha',
        labelText: 'Confirmar senha',
        prefixIcon: const Icon(Icons.key),
        suffixIcon: InkWell(
          onTap: () => setState(() => _esconderSenha = !_esconderSenha),
          child: Icon(_esconderSenha ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
