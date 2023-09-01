import 'package:bl_runners_firebase/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfilGenero extends StatefulWidget {
  const PaginaEditarPerfilGenero({super.key});

  @override
  State<PaginaEditarPerfilGenero> createState() => _PaginaEditarPerfilGeneroState();
}

class _PaginaEditarPerfilGeneroState extends State<PaginaEditarPerfilGenero> {
  @override
  void initState() {
    final controlador = context.read<PaginaEditarPerfilControlador>();
    final controladorUsuario = Provider.of<UserProvider>(context, listen: false);
    controlador.controladorGenero = controladorUsuario.usuarioModelo!.genero;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaEditarPerfilControlador>(context);

    return Form(
      key: controlador.globalKeyGenero,
      child: DropdownButtonFormField(
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
        decoration: InputDecoration(
          filled: true,
          hintText: 'Gênero',
          labelText: 'Gênero',
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
        onChanged: (valor) => setState(
          () {
            if (valor != controlador.controladorGenero) {
              controlador.controladorGenero = valor.toString();
            }
          },
        ),
      ),
    );
  }
}
