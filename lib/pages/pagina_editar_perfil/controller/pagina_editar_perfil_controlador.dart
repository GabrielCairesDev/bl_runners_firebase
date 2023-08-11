import 'dart:io';

import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/modelo_de_usuario.dart';
import '../../../providers/provider_usuario.dart';

class PaginaEditarPerfilControlador extends ChangeNotifier {
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
        alterarCarregando(context);
        editarDados(context);
      },
      onPressedNao: () => Navigator.of(context).pop(),
    );
  }

  editarDados(BuildContext context) async {
    final User? user = FirebaseAuth.instance.currentUser;
    late ModeloDeUsuario? usuario;
    if (user != null) {
      final usarioDados = await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).get();
      usuario = ModeloDeUsuario.fromMap(usarioDados.data() as Map<String, dynamic>);

      if (imagemArquivo != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child("perfil_fotos/${user.uid}");
        UploadTask uploadTask = ref.putFile(File(imagemArquivo!.path));

        uploadTask.snapshotEvents.listen(
          (TaskSnapshot taskSnapshot) {
            switch (taskSnapshot.state) {
              case TaskState.running:
                break;
              case TaskState.paused:
                alterarCarregando(context);
                break;
              case TaskState.canceled:
                alterarCarregando(context);
                break;
              case TaskState.error:
                Mensagens.snackBar(context, 'Algo deu errado');
                alterarCarregando(context);
                break;
              case TaskState.success:
                ref.getDownloadURL().then((url) => user.updatePhotoURL(url));
                break;
            }
          },
        );
      }

      user.updateDisplayName(controladorNome.text);

      final modeloDeUsuario = ModeloDeUsuario(
        nome: controladorNome.text,
        genero: controladorGenero,
        dataMascimento: nascimentoData,
        fotoUrl: user.photoURL,
        admin: usuario.admin,
        autorizado: usuario.autorizado,
        cadastroConcluido: usuario.cadastroConcluido,
        convidado: usuario.convidado,
        id: user.uid,
        master: usuario.master,
      );
      FirebaseFirestore.instance.collection('usuarios').doc(user.uid).update(modeloDeUsuario.toMap());
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) alterarCarregando(context);
    } else {
      Mensagens.snackBar(context, 'Algo deu errado');
      alterarCarregando(context);
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

  alterarCarregando(context) {
    carregando = !carregando;
    notifyListeners();
    final providerUsuario = Provider.of<ProviderUsuario>(context, listen: false);
    providerUsuario.atualizarUsuario();
  }
}
