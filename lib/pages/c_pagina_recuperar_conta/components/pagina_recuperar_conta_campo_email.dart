import 'package:bl_runners_firebase/pages/c_pagina_recuperar_conta/controller/pagina_recuperar_conta_controlador.dart';
import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:flutter/material.dart';

class PaginaRecuperarContaCampoEmail extends StatelessWidget {
  const PaginaRecuperarContaCampoEmail({super.key, required this.controlador});

  final PaginaRecuperarContaControlador controlador;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador.controladorEmail,
      validator: Validador.email,
      decoration: const InputDecoration(
        hintText: 'Digite o seu e-mail',
        labelText: 'E-mail',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }
}
