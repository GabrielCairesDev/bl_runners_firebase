import 'dart:io';

import 'package:bl_runners_firebase/providers/auth_provider.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PaginaEditarPerfilControlador extends ChangeNotifier {
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

  GlobalKey<FormState> globalKeyNome = GlobalKey();
  GlobalKey<FormState> globalKeyNascimento = GlobalKey();
  GlobalKey<FormState> globalKeyGenero = GlobalKey();
  GlobalKey<FormState> globalKeyFoto = GlobalKey();

  String? validadorNome(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  String? validadorNascimento(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  String? validadorGenero(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  String? validadorFoto(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;

  validarCampos(BuildContext context) {
    if (carregando == false &&
        globalKeyNome.currentState!.validate() &&
        globalKeyNascimento.currentState!.validate() &&
        globalKeyGenero.currentState!.validate() &&
        globalKeyFoto.currentState!.validate()) {
      perguntar(context);
    }
  }

  perguntar(context) {
    final controladorAuthprovider = Provider.of<AuthProvider>(context, listen: false);
    Mensagens.caixaDeDialogoSimNao(
      context,
      titulo: 'Atenção!',
      texto: 'Você deseja editar seus dados?',
      textoBotaoSim: 'Sim',
      textoBotaoNao: 'Não',
      onPressedSim: () {
        Navigator.of(context).pop();
        alterarCarregando();
        controladorAuthprovider.editarDados(context,
            imagemArquivo: imagemArquivo, nome: controladorNome.text, genero: controladorGenero.toString(), data: nascimentoData);
      },
      onPressedNao: () => Navigator.of(context).pop(),
    );
  }

  pedirsenha(BuildContext context) {
    final controladorAuthprovider = Provider.of<AuthProvider>(context, listen: false);
    Mensagens.caixaDialogoDigitarSenha(
      context,
      email: controladorSenha,
      titulo: 'Excluir Perfil?',
      textoBotaoExcluir: 'Excluir',
      textoBotaoCancelar: 'Cancelar',
      onPressedExcluir: () {
        alterarCarregando();
        controladorAuthprovider.excluirConta(context, senha: controladorSenha.text);
      },
      onPressedCancelar: () => Navigator.of(context).pop(),
    );
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

  alterarCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
