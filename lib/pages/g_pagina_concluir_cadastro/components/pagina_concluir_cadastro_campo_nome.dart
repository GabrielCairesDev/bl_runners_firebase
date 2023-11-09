import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_app/utils/validadores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controller/pagina_concluir_cadastro_controlador.dart';

class PaginaConcluirCampoNome extends StatefulWidget {
  const PaginaConcluirCampoNome(
      {super.key,
      required this.controladorConcluirCadastro,
      required this.controladorPegarUsuario});

  final PaginaConcluirCadastroControlador controladorConcluirCadastro;
  final PegarUsuarioAtual controladorPegarUsuario;

  @override
  State<PaginaConcluirCampoNome> createState() =>
      _PaginaConcluirCampoNomeState();
}

class _PaginaConcluirCampoNomeState extends State<PaginaConcluirCampoNome> {
  @override
  void initState() {
    super.initState();

    widget.controladorConcluirCadastro.controladorNome.text =
        widget.controladorPegarUsuario.usuarioAtual?.nome ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controladorConcluirCadastro.controladorNome,
      validator: Validador.nome,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-ZáÁâÂãÃàÀéÉêÊíÍóÓôÔõÕúÚüÜçÇ ]')),
      ],
      onChanged: (value) {
        widget.controladorConcluirCadastro.controladorNome.text =
            _observarPalavras(value);
        widget.controladorConcluirCadastro.controladorNome.selection =
            TextSelection.fromPosition(
          TextPosition(
              offset: widget
                  .controladorConcluirCadastro.controladorNome.text.length),
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
