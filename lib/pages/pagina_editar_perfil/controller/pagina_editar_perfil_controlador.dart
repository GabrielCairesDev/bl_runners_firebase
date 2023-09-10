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

class PaginaEditarPerfilControlador extends ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser;

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

  editarDados(
    BuildContext context,
  ) async {
    if (user != null) {
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
                await user!.updatePhotoURL(downloadUrl); // ATUALIZANDO NA RAIZ
            }
          },
        );
      }
      await user!.updateDisplayName(controladorNome.text); // ATUALIZANDO NA RAIZ

      final modeloDeUsuario = ModeloDeUsuario(
        // MANTER ORIGINAL
        id: user!.uid, // PEGAR DA RAIZ
        email: user!.email.toString(), // PEGAR DA RAIZ
        master: false, // controladorUsuario.usuarioModelo!.master
        admin: false, // controladorUsuario.usuarioModelo!.admin
        autorizado: false, // controladorUsuario.usuarioModelo!.admin
        cadastroConcluido: true,
        //ATUALIZAR
        nome: controladorNome.text,
        genero: controladorGenero.toString(),
        dataNascimento: nascimentoData,
        fotoUrl: user!.photoURL.toString(), // PEGAR DA RAIZ
      );

      await FirebaseFirestore.instance.collection('usuariosPerfil').doc(user!.uid).update(modeloDeUsuario.toJson());

      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) alterarCarregando();
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
    if (user != null) {
      try {
        final AuthCredential credential = EmailAuthProvider.credential(email: user!.email!, password: controladorSenha.text);
        await user!.reauthenticateWithCredential(credential);

        if (context.mounted) {
          Mensagens.snackBar(context, 'O seu perfil foi excluído!');
          context.pushReplacement(Rotas.entrar);
          alterarCarregando();
          controladorSenha.clear();
        }
        await FirebaseFirestore.instance.collection('usuariosPerfil').doc(user!.uid).delete();
        await FirebaseStorage.instance.ref().child("perfil_fotos/${user!.uid}").delete();
        await user!.delete();
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
