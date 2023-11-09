import 'dart:io';

import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_app/utils/validadores.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/pagina_editar_perfil_controlador.dart';

class PaginaEditarPerfilFoto extends StatefulWidget {
  const PaginaEditarPerfilFoto(
      {super.key,
      required this.controladorEditarPerfil,
      required this.controladorPegarUsuarioAtual});

  final PaginaEditarPerfilControlador controladorEditarPerfil;
  final PegarUsuarioAtual controladorPegarUsuarioAtual;

  @override
  State<PaginaEditarPerfilFoto> createState() => _PaginaEditarPerfilFotoState();
}

class _PaginaEditarPerfilFotoState extends State<PaginaEditarPerfilFoto> {
  @override
  void initState() {
    super.initState();
    final controlador = context.read<PaginaEditarPerfilControlador>();
    controlador.controladorFoto.text = 'Foto Atual';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.controladorEditarPerfil.imagemArquivo = null;
        return true;
      },
      child: Stack(
        children: [
          TextFormField(
            controller: widget.controladorEditarPerfil.controladorFoto,
            validator: Validador.foto,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.photo, color: Colors.blueGrey),
              filled: true,
              fillColor: const Color(0xFFEFEFEF),
              hintText: 'Foto do Perfil',
              labelText: 'Foto do Perfil',
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
            ),
            readOnly: true,
            onTap: () async {
              widget.controladorEditarPerfil.pegarFoto(ImageSource.gallery);
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
              child: widget.controladorEditarPerfil.imagemArquivo == null
                  ? _fotoPerfil()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.file(
                        File(
                            widget.controladorEditarPerfil.imagemArquivo!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  _fotoPerfil() {
    final fotoUrl = widget.controladorPegarUsuarioAtual.usuarioAtual?.fotoUrl;
    if (fotoUrl == null || fotoUrl.isEmpty) {
      return Image.asset('assets/images/avatar.png', fit: BoxFit.cover);
    } else {
      return CachedNetworkImage(
        imageUrl: fotoUrl,
        fit: BoxFit.cover,
        errorWidget: (context, error, stackTrace) {
          return Image.asset('assets/images/avatar.png', fit: BoxFit.cover);
        },
      );
    }
  }
}
