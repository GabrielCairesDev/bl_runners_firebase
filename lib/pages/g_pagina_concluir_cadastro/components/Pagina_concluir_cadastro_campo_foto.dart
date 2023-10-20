import 'dart:io';

import 'package:bl_runners_firebase/utils/validadores.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/pagina_concluir_cadastro_controlador.dart';

class PaginaConcluirCampoFoto extends StatelessWidget {
  const PaginaConcluirCampoFoto({super.key, required this.controladorConcluirCadastro});

  final PaginaConcluirCadastroControlador controladorConcluirCadastro;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: controladorConcluirCadastro.controladorFoto,
          validator: Validador.foto,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.photo, color: Colors.blueGrey),
            filled: true,
            fillColor: const Color(0xFFEFEFEF),
            hintText: 'Foto do Perfil',
            hintStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black),
            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
          ),
          readOnly: true,
          onTap: () async {
            controladorConcluirCadastro.pegarFoto(ImageSource.gallery);
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
            ),
            clipBehavior: Clip.hardEdge,
            child: controladorConcluirCadastro.imagemArquivo == null
                ? const Icon(Icons.person, color: Colors.white)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.file(
                      File(controladorConcluirCadastro.imagemArquivo!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
