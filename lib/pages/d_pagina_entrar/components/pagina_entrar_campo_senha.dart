import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:flutter/material.dart';

import '../controller/pagina_entrar_controlador.dart';

class PaginaEntrarCampoSenha extends StatefulWidget {
  const PaginaEntrarCampoSenha({super.key, required this.controlador});

  final PaginaEntrarControlador controlador;

  @override
  State<PaginaEntrarCampoSenha> createState() => _PaginaEntrarCampoSenhaState();
}

bool _esconderSenha = true;

class _PaginaEntrarCampoSenhaState extends State<PaginaEntrarCampoSenha> {
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
