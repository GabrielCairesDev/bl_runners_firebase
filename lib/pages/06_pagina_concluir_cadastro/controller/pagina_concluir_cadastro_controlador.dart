import 'dart:io';

import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/concluir_cadastro_use_case.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaginaConcluirCadastroControlador extends ChangeNotifier {
  final ConcluirCadastroUseCase concluirCadastroUseCase;

  PaginaConcluirCadastroControlador({required this.concluirCadastroUseCase});
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

  String? validadorNome(String? value) => value!.isEmpty ? 'Campo obrigatório!' : null;
  String? validadorNascimento(String? value) => value!.isEmpty ? 'Campo obrigatório!' : null;
  String? validadorGenero(String? value) => value!.isEmpty ? 'Campo obrigatório!' : null;
  String? validadorFoto(String? value) => value!.isEmpty ? 'Campo obrigatório!' : null;

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

  Future<String> concluirCadastro() async {
    alterarEstadoCarregando();

    if (globalKeyPaginaConcluirCadastro.currentState!.validate()) {
      final modeloDeUsuario = ModeloDeUsuario(
        id: '',
        nome: '',
        email: '',
        fotoUrl: '',
        genero: 'Masculino',
        master: false,
        admin: false,
        autorizado: false,
        cadastroConcluido: false,
        dataNascimento: DateTime.now(),
      );

      final resultado = concluirCadastroUseCase(
        modeloDeUsuario,
        imagemArquivo: imagemArquivo,
        nome: controladorNome.text,
        genero: controladorGenero.toString(),
        nascimento: nascimentoData as DateTime,
      );
      return resultado;
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
