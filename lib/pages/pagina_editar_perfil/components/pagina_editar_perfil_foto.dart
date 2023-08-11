import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider_usuario.dart';
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
    final controladorUsuario = context.read<ProviderUsuario>();
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
                  ? ClipRRect(
                      child: Image.network(
                        controladorUsuario.usuario!.fotoUrl.toString(),
                        fit: BoxFit.cover,
                      ),
                    )
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
}
