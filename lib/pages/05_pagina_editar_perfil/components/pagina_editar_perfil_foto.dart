import 'dart:io';

import 'package:bl_runners_firebase/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfilFoto extends StatefulWidget {
  const PaginaEditarPerfilFoto({super.key});

  @override
  State<PaginaEditarPerfilFoto> createState() => _PaginaEditarPerfilFotoState();
}

class _PaginaEditarPerfilFotoState extends State<PaginaEditarPerfilFoto> {
  @override
  void initState() {
    final controlador = context.read<PaginaEditarPerfilControlador>();
    controlador.controladorFoto.text = 'Foto Atual';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PaginaEditarPerfilControlador>(context);

    return WillPopScope(
      onWillPop: () async {
        controlador.imagemArquivo = null;
        return true;
      },
      child: Stack(
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
                labelText: 'Foto do Perfil',
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
                  ? fotoPerfil(context)
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
      ),
    );
  }

  fotoPerfil(BuildContext context) {
    final controladorDataProvider = Provider.of<DataProvider>(context);
    final foto = controladorDataProvider.modeloUsuario?.fotoUrl;

    if (foto == null || foto.isEmpty) {
      return Image.asset('assets/images/avatar.png');
    }

    return Image.network(
      controladorDataProvider.modeloUsuario!.fotoUrl.toString(),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/avatar.png');
      },
    );
  }
}