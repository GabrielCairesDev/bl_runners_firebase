import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controller/pagina_registrar_controlador.dart';

class PaginaRegistrarCampoNome extends StatelessWidget {
  const PaginaRegistrarCampoNome({super.key, required this.controlador});

  final PaginaRegistrarUsuarioControlador controlador;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador.controladorNome,
      validator: Validador.nome,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZáÁâÂãÃàÀéÉêÊíÍóÓôÔõÕúÚüÜçÇ ]')),
      ],
      onChanged: (value) {
        controlador.controladorNome.text = _observarPalavras(value);
        controlador.controladorNome.selection = TextSelection.fromPosition(
          TextPosition(offset: controlador.controladorNome.text.length),
        );
      },
      decoration: const InputDecoration(
        hintText: 'Digite o seu nome',
        labelText: 'Nome',
        prefixIcon: Icon(Icons.person),
      ),
    );
  }

  String _observarPalavras(String input) {
    List<String> words = input.split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].length > 2) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(' ');
  }
}
