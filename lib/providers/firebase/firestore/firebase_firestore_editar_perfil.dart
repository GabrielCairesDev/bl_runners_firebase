import 'dart:io';

import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/pages/05_pagina_editar_perfil/controller/pagina_editar_perfil_controlador.dart';
import 'package:bl_runners_firebase/providers/pegar_usuario.dart';
import 'package:bl_runners_firebase/providers/firebase/storage/firebase_storage_salvar_editar_foto_perfil.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FireBaseFireStoreEditarPerfil extends ChangeNotifier {
  Future<void> editarDados(
    BuildContext context, {
    required File? imagemArquivo,
    required String nome,
    required String genero,
    DateTime? data,
  }) async {
    final controladorPaginaEditarPerfil = Provider.of<PaginaEditarPerfilControlador>(context, listen: false);
    final controladorFirebaseStorageSalvarFotoPerfil = Provider.of<FirebaseStorageEditarFotoPerfil>(context, listen: false);
    final controladorDataProvider = Provider.of<PegarUsuario>(context, listen: false);

    final usuarioAtual = FirebaseAuth.instance.currentUser;

    if (usuarioAtual != null) {
      controladorFirebaseStorageSalvarFotoPerfil.editarFoto(context, imagemArquivo: imagemArquivo).then((value) async {
        final modeloDeUsuario = ModeloDeUsuario(
          // Manter original
          id: usuarioAtual.uid.toString(),
          email: usuarioAtual.email.toString(),
          master: controladorDataProvider.modeloUsuario?.master ?? false,
          admin: controladorDataProvider.modeloUsuario?.admin ?? false,
          autorizado: controladorDataProvider.modeloUsuario?.autorizado ?? false,
          cadastroConcluido: true,
          //  Novos  dados
          nome: nome.toString(),
          genero: genero.toString(),
          dataNascimento: data as DateTime,
          fotoUrl: value.toString(),
        );

        final documentoFirebase = await FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid.toString()).get();

        if (documentoFirebase.exists == false) await documentoFirebase.reference.set({});

        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(usuarioAtual.uid.toString())
            .collection('perfil')
            .doc('dados')
            .update(modeloDeUsuario.toJson())
            .then(
          (value) {
            Mensagens.mensagemSucesso(context, texto: 'Perfil editado com sucesso!');
            controladorPaginaEditarPerfil.alterarEstadoCarregando();
            context.pop();
          },
        ).catchError(
          (error) {
            Mensagens.mensagemErro(context, texto: 'Erro ao editar perfil: $error.');
            controladorPaginaEditarPerfil.alterarEstadoCarregando();
          },
        );
      }).catchError((error) {
        Mensagens.mensagemErro(context, texto: 'Erro ao carregar foto: $error.');
        controladorPaginaEditarPerfil.alterarEstadoCarregando();
      });
    } else {
      Mensagens.mensagemErro(context, texto: 'Erro ao editar perfil: Usuário null.');
      controladorPaginaEditarPerfil.alterarEstadoCarregando();
    }
  }
}
