import 'dart:io';

import 'package:bl_runners_firebase/providers/auth_provider.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/modelo_de_usuario.dart';
import '../../../providers/user_provider.dart';

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
    Mensagens.caixaDeDialogoSimNao(
      context,
      titulo: 'Atenção!',
      texto: 'Você deseja editar seus dados?',
      textoBotaoSim: 'Sim',
      textoBotaoNao: 'Não',
      onPressedSim: () {
        Navigator.of(context).pop();
        alterarCarregando();
        editarDados(context);
      },
      onPressedNao: () => Navigator.of(context).pop(),
    );
  }

  editarDados(BuildContext context) async {
    final controladorAuth = Provider.of<AuthProvider>(context, listen: false);
    final controladorUsuario = Provider.of<UserProvider>(context, listen: false);
    if (controladorAuth.usuario != null) {
      if (imagemArquivo != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("perfil_fotos/${FirebaseAuth.instance.currentUser?.uid}");
        UploadTask uploadTask = ref.putFile(File(imagemArquivo!.path));
        uploadTask.snapshotEvents.listen(
          (TaskSnapshot taskSnapshot) async {
            switch (taskSnapshot.state) {
              case TaskState.running:
                break;
              case TaskState.paused:
                alterarCarregando();
                break;
              case TaskState.canceled:
                alterarCarregando();
                break;
              case TaskState.error:
                Mensagens.snackBar(context, 'Algo deu errado');
                alterarCarregando();
                break;
              case TaskState.success:
                var downloadUrl = await ref.getDownloadURL();
                await controladorAuth.usuario?.updatePhotoURL(downloadUrl); // ATUALIZANDO NA RAIZ
            }
          },
        );
      }
      await controladorAuth.usuario?.updateDisplayName(controladorNome.text); // ATUALIZANDO NA RAIZ

      final modeloDeUsuario = ModeloDeUsuario(
        // MANTER ORIGINAL
        id: controladorAuth.usuario!.uid, // PEGAR DA RAIZ
        email: controladorAuth.usuario!.email.toString(), // PEGAR DA RAIZ
        master: controladorUsuario.usuarioModelo!.master,
        admin: controladorUsuario.usuarioModelo!.admin,
        autorizado: controladorUsuario.usuarioModelo!.autorizado,
        cadastroConcluido: controladorUsuario.usuarioModelo!.cadastroConcluido,
        //ATUALIZAR
        nome: controladorNome.text,
        genero: controladorGenero.toString(),
        dataNascimento: nascimentoData,
        fotoUrl: controladorAuth.usuario!.photoURL.toString(), // PEGAR DA RAIZ
      );

      await FirebaseFirestore.instance.collection('usuarios').doc(controladorAuth.usuario!.uid).update(modeloDeUsuario.toJson());
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) alterarCarregando();

      controladorUsuario.pegarUsuarioAtualizado(controladorAuth.usuario);
    } else {
      Mensagens.snackBar(context, 'Algo deu errado');
      alterarCarregando();
    }
  }

  pedirsenha(BuildContext context) {
    Mensagens.caixaDialogoDigitarSenha(
      context,
      senha: controladorSenha,
      titulo: 'Excluir Perfil?',
      textoBotaoExcluir: 'Excluir',
      textoBotaoCancelar: 'Cancelar',
      onPressedExcluir: () {
        alterarCarregando();
        return excluirConta(context);
      },
      onPressedCancelar: () => Navigator.of(context).pop(),
    );
  }

  excluirConta(BuildContext context) async {
    final controladorUsuario = Provider.of<AuthProvider>(context, listen: false);

    if (controladorUsuario.usuario != null) {
      try {
        final AuthCredential credential = EmailAuthProvider.credential(email: controladorUsuario.usuario!.email!, password: controladorSenha.text);
        await controladorUsuario.usuario!.reauthenticateWithCredential(credential);

        if (context.mounted) {
          Mensagens.snackBar(context, 'O seu perfil foi excluído!');
          context.pushReplacement(Rotas.entrar);
          alterarCarregando();
          controladorSenha.clear();
        }
        await FirebaseFirestore.instance.collection('usuarios').doc(controladorUsuario.usuario!.uid).delete();
        await FirebaseStorage.instance.ref().child("perfil_fotos/${controladorUsuario.usuario!.uid}").delete();
        await controladorUsuario.usuario!.delete();
      } catch (e) {
        if (context.mounted) Navigator.of(context).pop();
        if (context.mounted) Mensagens.snackBar(context, 'Senha inválida!');
        alterarCarregando();
        controladorSenha.clear();
      }
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

  alterarCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
