import 'package:bl_runners_firebase/providers/provider_usuario.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfilNome extends StatelessWidget {
  const PaginaEditarPerfilNome({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaEditarPerfilControlador>();

    final controladorUsuario = context.read<ProviderUsuario>();
    controlador.controladorNome.text = controladorUsuario.usuario!.nome!;

    return Form(
      key: controlador.globalKeyNome,
      child: TextFormField(
        controller: controlador.controladorNome,
        validator: controlador.validadorNome,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZáÁâÂãÃàÀéÉêÊíÍóÓôÔõÕúÚüÜçÇ ]')),
        ],
        onChanged: (value) {
          controlador.controladorNome.text = observarPalavras(value);
          controlador.controladorNome.selection = TextSelection.fromPosition(
            TextPosition(offset: controlador.controladorNome.text.length),
          );
        },
        decoration: const InputDecoration(
          hintText: 'Digite o seu nome',
          labelText: 'Nome',
          prefixIcon: Icon(Icons.person),
        ),
      ),
    );
  }

  String observarPalavras(String input) {
    List<String> words = input.split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].length > 2) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(' ');
  }
}
