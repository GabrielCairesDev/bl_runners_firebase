import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/pages/06_pagina_concluir_cadastro/controller/pagina_concluir_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/storage/firebase_storage_salvar_foto_perfil.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FireBaseFireStoreConcluirCadastro extends ChangeNotifier {
  Future<void> concluirCadastro(BuildContext context, {required imagemArquivo}) async {
    User? usuarioAtual = FirebaseAuth.instance.currentUser;

    final controladorPaginaConcluirCadastro = Provider.of<PaginaConcluirControlador>(context, listen: false);
    final controladorFirebaseStorageSalvarFotoPerfil = Provider.of<FirebaseStorageSalvarFotoPerfil>(context, listen: false);

    if (usuarioAtual != null) {
      controladorFirebaseStorageSalvarFotoPerfil.salvarFoto(context, imagemArquivo: imagemArquivo).then((value) async {
        final modeloDeUsuario = ModeloDeUsuario(
          id: usuarioAtual.uid,
          nome: controladorPaginaConcluirCadastro.controladorNome.text,
          email: usuarioAtual.email.toString(),
          fotoUrl: value.toString(),
          genero: controladorPaginaConcluirCadastro.controladorGenero.toString(),
          master: false,
          admin: false,
          autorizado: false,
          cadastroConcluido: true,
          dataNascimento: controladorPaginaConcluirCadastro.nascimentoData as DateTime,
        );

        final documentoFirebase = await FirebaseFirestore.instance.collection('usuarios').doc(usuarioAtual.uid.toString()).get();

        if (documentoFirebase.exists == false) await documentoFirebase.reference.set({});

        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(usuarioAtual.uid.toString())
            .collection('perfil')
            .doc('dados')
            .set(modeloDeUsuario.toJson())
            .then(
          (value) {
            Mensagens.mensagemSucesso(context, texto: 'Cadastro concluido!');
            controladorPaginaConcluirCadastro.alterarEstadoCarregando();
            context.pop();
          },
        ).catchError(
          (error) {
            Mensagens.mensagemErro(context, texto: 'Erro ao concluir cadastro: $error.');
            controladorPaginaConcluirCadastro.alterarEstadoCarregando();
          },
        );
      }).catchError((error) {
        Mensagens.mensagemErro(context, texto: 'Erro ao carregar foto: $error.');
        controladorPaginaConcluirCadastro.alterarEstadoCarregando();
      });
    } else {
      Mensagens.mensagemErro(context, texto: 'Erro ao concluir cadastro: Usuário null.');
      controladorPaginaConcluirCadastro.alterarEstadoCarregando();
    }
  }
}
