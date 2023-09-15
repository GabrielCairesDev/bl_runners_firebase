import 'dart:io';

import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_concluir_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PaginaConcluirControlador extends ChangeNotifier {
  final controladorNome = TextEditingController();
  final controladorNascimento = TextEditingController();
  final controladorFoto = TextEditingController();

  String? controladorGenero;
  List<String> generos = ['Masculino', 'Feminino'];
  DateTime? nascimentoData;
  bool carregando = false;

  XFile? imagemCaminho;
  File? imagemArquivo;

  final GlobalKey<FormState> globalKeyPaginaConcluirCadastro = GlobalKey<FormState>();

  String? validadorNome(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  String? validadorNascimento(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  String? validadorGenero(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  String? validadorFoto(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;

  validarCampos(context) {
    if (carregando == false && globalKeyPaginaConcluirCadastro.currentState!.validate()) {
      salvarDados(context);
    }
  }

  salvarDados(BuildContext context) async {
    final controladorFireBaseFireStoreConcluirCadastro = Provider.of<FireBaseFireStoreConcluirCadastro>(context, listen: false);
    alterarEstadoCarregando();
    controladorFireBaseFireStoreConcluirCadastro.concluirCadastro(context, imagemArquivo: imagemArquivo);
  }

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

  resetarValores() {
    controladorFoto.clear();
  }

  alterarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
