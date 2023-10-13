import 'dart:io';

import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/concluir_cadastro_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/salvar_foto_use_case.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaginaConcluirCadastroControlador extends ChangeNotifier {
  final ConcluirCadastroUseCase concluirCadastroUseCase;
  final SalvarFotoUseCase salvarFotoUseCase;

  PaginaConcluirCadastroControlador({required this.concluirCadastroUseCase, required this.salvarFotoUseCase});
  final controladorNome = TextEditingController();
  final controladorNascimento = TextEditingController();
  final controladorFoto = TextEditingController();

  final GlobalKey<FormState> globalKeyPaginaConcluirCadastro = GlobalKey<FormState>();

  String? controladorGenero;
  List<String> generos = ['Masculino', 'Feminino'];
  DateTime? nascimentoData;
  bool carregando = false;

  XFile? imagemCaminho;
  File? imagemArquivo;

  Future<void> pegarFoto(ImageSource source) async {
    try {
      final ImagePicker pegarImagem = ImagePicker();
      imagemCaminho = await pegarImagem.pickImage(
        source: source,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 50,
      );

      if (imagemCaminho != null) {
        imagemArquivo = File(imagemCaminho!.path);
        controladorFoto.text = 'Foto Selecionada';
        notifyListeners();
      }
    } catch (e) {
      debugPrint('error $e');
    }
  }

  Future<String> concluirCadastro({required String? idUsuario, required bool usuarioAutorizado}) async {
    final internet = await Connectivity().checkConnectivity();

    if (internet == ConnectivityResult.none) throw 'Sem conexão com a internet!';
    if (idUsuario == null || idUsuario.isEmpty) throw 'Usuário vázio ou Null!';
    if (usuarioAutorizado == false) throw 'Usuário não autorizado!';

    final usuarioAtual = FirebaseAuth.instance.currentUser;
    if (globalKeyPaginaConcluirCadastro.currentState!.validate()) {
      if (usuarioAtual == null) throw 'Usuário Null';

      alterarEstadoCarregando();

      final fotoURL = await salvarFotoUseCase(imagemArquivo: imagemArquivo, usuarioAtual: usuarioAtual);

      final modeloDeUsuario = ModeloDeUsuario(
        id: usuarioAtual.uid,
        nome: controladorNome.text,
        email: usuarioAtual.email.toString(),
        fotoUrl: fotoURL.toString(),
        genero: controladorGenero.toString(),
        master: false,
        admin: false,
        autorizado: false,
        cadastroConcluido: true,
        dataNascimento: nascimentoData as DateTime,
      );

      try {
        final resultado = await concluirCadastroUseCase(modeloDeUsuario, usuarioAtual);
        return resultado;
      } catch (e) {
        rethrow;
      } finally {
        alterarEstadoCarregando();
      }
    }
    throw 'Preencha todos os campos!';
  }

  resetarValores() {
    controladorFoto.clear();
  }

  alterarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
