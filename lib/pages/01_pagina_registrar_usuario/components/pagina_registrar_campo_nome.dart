import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoNome extends StatelessWidget {
  const PaginaRegistrarCampoNome({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaRegistrar = context.read<PaginaRegistrarUsuarioControlador>();
    return TextFormField(
      controller: controladorPaginaRegistrar.controladorNome,
      validator: controladorPaginaRegistrar.validadorNome,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZáÁâÂãÃàÀéÉêÊíÍóÓôÔõÕúÚüÜçÇ ]')),
      ],
      onChanged: (value) {
        controladorPaginaRegistrar.controladorNome.text = observarPalavras(value);
        controladorPaginaRegistrar.controladorNome.selection = TextSelection.fromPosition(
          TextPosition(offset: controladorPaginaRegistrar.controladorNome.text.length),
        );
      },
      decoration: const InputDecoration(
        hintText: 'Digite o seu nome',
        labelText: 'Nome',
        prefixIcon: Icon(Icons.person),
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
