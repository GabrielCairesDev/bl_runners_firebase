import 'package:bl_runners_firebase/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfilNome extends StatefulWidget {
  const PaginaEditarPerfilNome({super.key, required this.controladorEditarPerfil, required this.controladorPegarUsuario});

  final PaginaEditarPerfilControlador controladorEditarPerfil;
  final PegarUsuarioAtual controladorPegarUsuario;

  @override
  State<PaginaEditarPerfilNome> createState() => _PaginaEditarPerfilNomeState();
}

class _PaginaEditarPerfilNomeState extends State<PaginaEditarPerfilNome> {
  @override
  void initState() {
    super.initState();
    widget.controladorEditarPerfil.controladorNome.text = widget.controladorPegarUsuario.usuarioAtual?.nome ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaEditarPerfilControlador>(context);

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

  _observarPalavras(String input) {
    List<String> words = input.split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].length > 2) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(' ');
  }
}
