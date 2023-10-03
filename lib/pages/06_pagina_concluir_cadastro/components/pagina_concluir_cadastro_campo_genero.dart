import 'package:flutter/material.dart';

import '../controller/pagina_concluir_cadastro_controlador.dart';

class PaginaRegistrarCampoGenero extends StatefulWidget {
  const PaginaRegistrarCampoGenero({super.key, required this.controladorConcluirCadastro});

  final PaginaConcluirCadastroControlador controladorConcluirCadastro;

  @override
  State<PaginaRegistrarCampoGenero> createState() => _PaginaRegistrarCampoGeneroState();
}

class _PaginaRegistrarCampoGeneroState extends State<PaginaRegistrarCampoGenero> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            hintText: 'Gênero',
            prefixIcon: Icon(
              widget.controladorConcluirCadastro.controladorGenero == 'Masculino' ? Icons.male : Icons.female,
            ),
          ),
          value: widget.controladorConcluirCadastro.controladorGenero,
          onChanged: (valor) {
            setState(() {
              widget.controladorConcluirCadastro.controladorGenero = valor!;
            });
          },
          items: widget.controladorConcluirCadastro.generos.map((genero) {
            return DropdownMenuItem<String>(
              value: genero,
              child: Text(genero),
            );
          }).toList(),
          validator: (valor) {
            if (!widget.controladorConcluirCadastro.generos.contains(valor)) {
              return 'Campo obrigatório';
            }
            return null;
          },
        ),
      ],
    );
  }
}
