import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/editar_perfil_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/excluir_conta_use_case.dart';

class PaginaEditarPerfilControlador extends ChangeNotifier {
  final ExcluirContaUseCase excluirContaUseCase;
  final EditarPerfil editarPerfilUseCase;

  PaginaEditarPerfilControlador({
    required this.excluirContaUseCase,
    required this.editarPerfilUseCase,
  });

  final controladorNome = TextEditingController();
  final controladorNascimento = TextEditingController();
  final controladorFoto = TextEditingController();
  final controladorSenha = TextEditingController();

  String? controladorGenero;
  List<String> generos = ['Masculino', 'Feminino'];
  late DateTime nascimentoData;
  bool carregando = false;

  XFile? imagemCaminho;
  File? imagemArquivo;

  final GlobalKey<FormState> globalKeyPaginaEditarPerfil = GlobalKey<FormState>();

  Future<String> editarPerfil() async {
    if (globalKeyPaginaEditarPerfil.currentState!.validate()) {
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

      try {
        alterarEstadoCarregando();
        final resultado = await editarPerfilUseCase(
          modeloDeUsuario,
          imagemArquivo: imagemArquivo,
          nome: controladorNome.text,
          genero: controladorGenero.toString(),
          nascimentoData: nascimentoData,
        );
        return resultado;
      } catch (e) {
        rethrow;
      } finally {
        alterarEstadoCarregando();
      }
    }
    throw 'Preencha todos os campos!';
  }

  Future<String> excluirConta() async {
    try {
      alterarEstadoCarregando();
      final resultado = await excluirContaUseCase(senha: controladorSenha.text);
      return resultado;
    } catch (e) {
      rethrow;
    } finally {
      alterarEstadoCarregando();
    }
  }

  Future<void> pegarFoto(ImageSource source) async {
    try {
      final ImagePicker pegarImagem = ImagePicker();
      imagemCaminho = await pegarImagem.pickImage(
        source: source,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 70,
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

  alterarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
