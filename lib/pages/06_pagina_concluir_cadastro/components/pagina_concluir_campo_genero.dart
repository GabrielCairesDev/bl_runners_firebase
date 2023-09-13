import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_concluir_controlador.dart';

class PaginaRegistrarCampoGenero extends StatefulWidget {
  const PaginaRegistrarCampoGenero({super.key});

  @override
  State<PaginaRegistrarCampoGenero> createState() => _PaginaRegistrarCampoGeneroState();
}

class _PaginaRegistrarCampoGeneroState extends State<PaginaRegistrarCampoGenero> {
  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaConcluirControlador>(context);
    return DropdownButtonFormField(
      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
      decoration: InputDecoration(
        filled: true,
        hintText: 'Gênero',
        prefixIcon: Icon(
          controlador.controladorGenero == 'Masculino' ? Icons.male : Icons.female,
        ),
      ),
      isExpanded: true,
      isDense: true,
      value: controlador.controladorGenero,
      selectedItemBuilder: (BuildContext context) {
        return controlador.generos.map<Widget>(
          (String texto) {
            return DropdownMenuItem(
              value: texto,
              child: Text(
                texto,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          },
        ).toList();
      },
      items: controlador.generos.map(
        (generoEscolhido) {
          if (generoEscolhido == controlador.controladorGenero) {
            return DropdownMenuItem(
              value: generoEscolhido,
              child: Text(
                generoEscolhido,
                style: const TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            );
          } else {
            return DropdownMenuItem(
              value: generoEscolhido,
              child: Text(
                generoEscolhido,
                style: const TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            );
          }
        },
      ).toList(),
      validator: controlador.validadorGenero,
      onChanged: (valor) {
        if (valor != null) {
          setState(
            () => controlador.controladorGenero = valor.toString(),
          );
        }
      },
    );
  }
}
