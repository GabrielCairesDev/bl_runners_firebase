import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfilNome extends StatefulWidget {
  const PaginaEditarPerfilNome({super.key});

  @override
  State<PaginaEditarPerfilNome> createState() => _PaginaEditarPerfilNomeState();
}

class _PaginaEditarPerfilNomeState extends State<PaginaEditarPerfilNome> {
  @override
  void initState() {
    final controladorEditarControlador = Provider.of<PaginaEditarPerfilControlador>(context, listen: false);
    final controladorDataProvider = Provider.of<PegarUsuario>(context, listen: false);
    controladorEditarControlador.controladorNome.text = controladorDataProvider.modeloUsuario?.nome ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaEditarPerfilControlador>(context);

    return TextFormField(
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
