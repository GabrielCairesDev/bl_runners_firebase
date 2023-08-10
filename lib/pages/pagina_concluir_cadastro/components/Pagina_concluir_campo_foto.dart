import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_concluir_controlador.dart';

class PaginaConcluirCampoFoto extends StatelessWidget {
  const PaginaConcluirCampoFoto({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaConcluirControlador>(context);
    return Stack(
      children: [
        Form(
          key: controlador.globalKeyFoto,
          child: TextFormField(
            controller: controlador.controladorFoto,
            validator: controlador.validadorFoto,
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
              controlador.pegarFoto(ImageSource.gallery);
            },
          ),
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
            child: controlador.imagemArquivo == null
                ? const Icon(Icons.person, color: Colors.white)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.file(
                      File(controlador.imagemArquivo!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
