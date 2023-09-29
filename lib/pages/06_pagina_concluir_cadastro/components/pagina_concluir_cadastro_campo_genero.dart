import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_concluir_cadastro_controlador.dart';

class PaginaRegistrarCampoGenero extends StatefulWidget {
  const PaginaRegistrarCampoGenero({super.key});

  @override
  State<PaginaRegistrarCampoGenero> createState() => _PaginaRegistrarCampoGeneroState();
}

class _PaginaRegistrarCampoGeneroState extends State<PaginaRegistrarCampoGenero> {
  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaConcluirCadastroControlador>(context);
    return Column(
      children: [
        DropdownButtonFormField<String>(
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            hintText: 'Gênero',
            prefixIcon: Icon(
              controlador.controladorGenero == 'Masculino' ? Icons.male : Icons.female,
            ),
          ),
          value: controlador.controladorGenero,
          onChanged: (valor) {
            setState(() {
              controlador.controladorGenero = valor!;
            });
          },
          items: controlador.generos.map((genero) {
            return DropdownMenuItem<String>(
              value: genero,
              child: Text(genero),
            );
          }).toList(),
          validator: (valor) {
            if (!controlador.generos.contains(valor)) {
              return 'Campo obrigatório';
            }
            return null;
          },
        ),
      ],
    );
  }
}
