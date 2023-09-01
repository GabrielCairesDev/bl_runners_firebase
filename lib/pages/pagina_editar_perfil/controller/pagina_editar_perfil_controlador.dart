import 'dart:io';

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
import '../../../providers/provider_usuario.dart';

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
    final controladorUsuario = context.read<ProviderUsuario>();
    if (FirebaseAuth.instance.currentUser != null) {
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
                await FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl); // ATUALIZANDO NA RAIZ
            }
          },
        );
      }
      await FirebaseAuth.instance.currentUser?.updateDisplayName(controladorNome.text); // ATUALIZANDO NA RAIZ

      final modeloDeUsuario = ModeloDeUsuario(
        // MANTER ORIGINAL
        id: FirebaseAuth.instance.currentUser!.uid, // PEGAR DA RAIZ
        email: FirebaseAuth.instance.currentUser!.email.toString(), // PEGAR DA RAIZ
        master: controladorUsuario.usuario!.master,
        admin: controladorUsuario.usuario!.admin,
        autorizado: controladorUsuario.usuario!.autorizado,
        cadastroConcluido: controladorUsuario.usuario!.cadastroConcluido,
        //ATUALIZAR
        nome: FirebaseAuth.instance.currentUser!.displayName.toString(), // PEGAR DA RAIZ
        fotoUrl: FirebaseAuth.instance.currentUser!.photoURL.toString(), // PEGAR DA RAIZ
        genero: controladorGenero.toString(),
        dataNascimento: nascimentoData,
      );

      await FirebaseFirestore.instance.collection('usuarios').doc(FirebaseAuth.instance.currentUser!.uid).update(modeloDeUsuario.toJson());
      controladorUsuario.atualizarUsuario();
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) alterarCarregando();
      controladorUsuario.atualizarUsuario();
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
    final controladorUsuario = context.read<ProviderUsuario>();

    if (controladorUsuario.user != null) {
      try {
        final AuthCredential credential = EmailAuthProvider.credential(email: controladorUsuario.user!.email!, password: controladorSenha.text);
        await controladorUsuario.user!.reauthenticateWithCredential(credential);

        if (context.mounted) {
          Mensagens.snackBar(context, 'O seu perfil foi excluído!');
          context.pushReplacement(Rotas.entrar);
          alterarCarregando();
          controladorSenha.clear();
        }
        await FirebaseFirestore.instance.collection('usuarios').doc(controladorUsuario.user!.uid).delete();
        await FirebaseStorage.instance.ref().child("perfil_fotos/${controladorUsuario.user!.uid}").delete();
        await controladorUsuario.user!.delete();
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
