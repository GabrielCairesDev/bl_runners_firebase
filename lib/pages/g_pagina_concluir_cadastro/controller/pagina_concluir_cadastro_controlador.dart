import 'dart:io';

import 'package:bl_runners_firebase/providers/interfaces/concluir_cadastro_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaginaConcluirCadastroControlador extends ChangeNotifier {
  PaginaConcluirCadastroControlador({required this.concluirCadastroUseCase});

  final ConcluirCadastroUseCase concluirCadastroUseCase;

  final TextEditingController controladorNome = TextEditingController();
  final TextEditingController controladorNascimento = TextEditingController();
  final TextEditingController controladorFoto = TextEditingController();

  final GlobalKey<FormState> globalKeyPaginaConcluirCadastro = GlobalKey<FormState>();

  bool carregando = false;

  List<String> generos = ['Masculino', 'Feminino'];
  String? controladorGenero;
  Timestamp? dataNascimento;

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

  Future<String> concluirCadastro({required bool usuarioAutorizado}) async {
    final internet = await Connectivity().checkConnectivity();

    if (internet == ConnectivityResult.none) throw 'Sem conexão com a internet!';
    if (usuarioAutorizado == false) throw 'Usuário não autorizado!';

    if (globalKeyPaginaConcluirCadastro.currentState!.validate()) {
      try {
        _alterarEstadoCarregando();

        final resultado = await concluirCadastroUseCase(
          imagemArquivo: imagemArquivo,
          dataNascimento: dataNascimento as Timestamp,
          genero: controladorGenero.toString(),
          nome: controladorNome.text,
        );

        _resetarValores();
        return resultado;
      } catch (e) {
        rethrow;
      } finally {
        _alterarEstadoCarregando();
      }
    }
    throw 'Preencha todos os campos!';
  }

  _resetarValores() {
    controladorNome.clear();
    controladorNascimento.clear();
    controladorFoto.clear();
    notifyListeners();
  }

  _alterarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
