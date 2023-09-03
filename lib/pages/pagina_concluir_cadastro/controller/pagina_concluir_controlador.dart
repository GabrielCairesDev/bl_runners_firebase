import 'dart:io';

import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/modelo_de_usuario.dart';
import '../../../routes/rotas.dart';

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

  GlobalKey<FormState> globalKeyNome = GlobalKey();
  GlobalKey<FormState> globalKeyNascimento = GlobalKey();
  GlobalKey<FormState> globalKeyGenero = GlobalKey();
  GlobalKey<FormState> globalKeyFoto = GlobalKey();

  String? validadorNome(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  String? validadorNascimento(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  String? validadorGenero(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  String? validadorFoto(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;

  validarCampos(context) {
    if (carregando == false &&
        globalKeyNome.currentState!.validate() &&
        globalKeyGenero.currentState!.validate() &&
        globalKeyNascimento.currentState!.validate() &&
        globalKeyFoto.currentState!.validate()) {
      alterarCarregando();
      salvarDados(context);
    }
  }

  salvarDados(BuildContext context) async {
    final usuario = FirebaseAuth.instance.currentUser;
    if (usuario != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("perfil_fotos/${usuario.uid}");
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
              usuario.updatePhotoURL(downloadUrl);

              final modeloDeUsuario = ModeloDeUsuario(
                id: usuario.uid,
                nome: controladorNome.text,
                email: usuario.email.toString(),
                fotoUrl: downloadUrl,
                genero: controladorGenero.toString(),
                master: false,
                admin: false,
                autorizado: false,
                cadastroConcluido: true,
                dataNascimento: nascimentoData as DateTime,
              );

              FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).set(modeloDeUsuario.toJson());
              if (context.mounted) context.pushReplacement(Rotas.navegar);
              alterarCarregando();
              break;
          }
        },
      );
    } else {
      Mensagens.snackBar(context, 'Algo deu errado');
      alterarCarregando();
    }
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

  alterarCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
