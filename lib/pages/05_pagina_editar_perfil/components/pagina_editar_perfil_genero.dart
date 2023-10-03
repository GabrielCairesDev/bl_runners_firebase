import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario.dart';
import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:flutter/material.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfilGenero extends StatefulWidget {
  const PaginaEditarPerfilGenero({super.key, required this.controladorEditarPerfil, required this.controladorPegarUsuario});

  final PaginaEditarPerfilControlador controladorEditarPerfil;
  final PegarUsuario controladorPegarUsuario;

  @override
  State<PaginaEditarPerfilGenero> createState() => _PaginaEditarPerfilGeneroState();
}

class _PaginaEditarPerfilGeneroState extends State<PaginaEditarPerfilGenero> {
  @override
  void initState() {
    super.initState();
    widget.controladorEditarPerfil.controladorGenero = widget.controladorPegarUsuario.modeloUsuario?.genero ?? 'Masculino';
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
      decoration: InputDecoration(
        filled: true,
        hintText: 'Gênero',
        labelText: 'Gênero',
        prefixIcon: Icon(
          widget.controladorEditarPerfil.controladorGenero == 'Masculino' ? Icons.male : Icons.female,
        ),
      ),
      isExpanded: true,
      isDense: true,
      value: widget.controladorEditarPerfil.controladorGenero,
      selectedItemBuilder: (BuildContext context) {
        return widget.controladorEditarPerfil.generos.map<Widget>(
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
      items: widget.controladorEditarPerfil.generos.map(
        (generoEscolhido) {
          if (generoEscolhido == widget.controladorEditarPerfil.controladorGenero) {
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
      validator: Validador.genero,
      onChanged: (valor) => setState(
        () {
          if (valor != widget.controladorEditarPerfil.controladorGenero) {
            widget.controladorEditarPerfil.controladorGenero = valor.toString();
          }
        },
      ),
    );
  }
}
