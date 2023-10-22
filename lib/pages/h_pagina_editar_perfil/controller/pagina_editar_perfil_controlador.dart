import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bl_runners_firebase/providers/interfaces/editar_perfil_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/excluir_conta_use_case.dart';

class PaginaEditarPerfilControlador extends ChangeNotifier {
  PaginaEditarPerfilControlador({
    required this.excluirContaUseCase,
    required this.editarPerfilUseCase,
  });

  final ExcluirContaUseCase excluirContaUseCase;
  final EditarPerfil editarPerfilUseCase;

  final TextEditingController controladorNome = TextEditingController();
  final TextEditingController controladorNascimento = TextEditingController();
  final TextEditingController controladorFoto = TextEditingController();
  final TextEditingController controladorSenha = TextEditingController();

  String? controladorGenero;
  List<String> generos = ['Masculino', 'Feminino'];
  late Timestamp? dataNascimento;
  bool carregando = false;

  XFile? imagemCaminho;
  File? imagemArquivo;

  final GlobalKey<FormState> globalKeyPaginaEditarPerfil = GlobalKey<FormState>();

  Future<void> pegarFoto(ImageSource source) async {
    try {
      final ImagePicker pegarImagem = ImagePicker();
      imagemCaminho = await pegarImagem.pickImage(
        source: source,
        // maxHeight: 512,
        // maxWidth: 512,
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

  Future<String> editarPerfil({required String? idUsuario}) async {
    final internet = await Connectivity().checkConnectivity();

    if (internet == ConnectivityResult.none) throw 'Sem conexão com a internet!';
    if (idUsuario == null || idUsuario.isEmpty) throw 'Usuário vázio ou Null!';

    if (globalKeyPaginaEditarPerfil.currentState!.validate()) {
      try {
        _alterarEstadoCarregando();
        final resultado = await editarPerfilUseCase(
          imagemArquivo: imagemArquivo,
          nome: controladorNome.text,
          genero: controladorGenero.toString(),
          dataNascimento: dataNascimento as Timestamp,
        );
        return resultado;
      } catch (e) {
        rethrow;
      } finally {
        _alterarEstadoCarregando();
      }
    }
    throw 'Preencha todos os campos!';
  }

  Future<String> excluirConta({required String? idUsuario}) async {
    final internet = await Connectivity().checkConnectivity();

    if (internet == ConnectivityResult.none) throw 'Sem conexão com a internet!';
    if (idUsuario == null || idUsuario.isEmpty) throw 'Usuário vázio ou Null!';

    try {
      _alterarEstadoCarregando();
      final resultado = await excluirContaUseCase(senha: controladorSenha.text);
      return resultado;
    } catch (e) {
      rethrow;
    } finally {
      controladorSenha.clear();
      _alterarEstadoCarregando();
    }
  }

  _alterarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
