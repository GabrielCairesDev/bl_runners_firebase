import 'package:bl_runners_firebase/models/mode_de_atividade.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PaginaRegistrarAtividadeControlador extends ChangeNotifier {
  final controladorCampoTitulo = TextEditingController();
  final controladorCampoDescricao = TextEditingController();
  final controladorCampoData = TextEditingController();
  final controladorCampoTempo = TextEditingController();
  final controladorCampoTipo = TextEditingController();

  final GlobalKey<FormState> globalKeyRegistrarAtividade = GlobalKey<FormState>();

  DateTime? dataHoraSelecionada;
  String? dataHoraFormatadaSalvar;
  TimeOfDay? tempo;
  int? tempoMinutos;
  int controladorDistancia = 5000;
  bool carregando = false;

  String? validadorTitulo(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;
  String? validadorDescricao(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;
  String? validadorData(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;
  String? validadorTipo(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;

  String? validadorTempo(value) {
    if (value == null || tempo == null) {
      return 'Campo Obrigatório';
    } else if (tempo!.minute < 1 && tempo!.hour < 1) {
      return 'Tempo Inválido';
    }
    return null;
  }

  validar(context) {
    if (globalKeyRegistrarAtividade.currentState!.validate()) {
      salvar(context);
    }
  }

  salvar(BuildContext context) async {
    alterarCarregando();
    // Pegar usuário
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final modeloDeAtividade = ModeloDeAtividade(
        id: user.uid,
        titulo: controladorCampoTitulo.text,
        descricao: controladorCampoDescricao.text,
        tipo: controladorCampoTipo.text,
        tempo: tempoMinutos as int,
        distancia: controladorDistancia,
        dataAtividade: dataHoraSelecionada as DateTime,
      );

      final documento = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .collection('atividades')
          .doc(dataHoraSelecionada!.year.toString())
          .collection(dataHoraSelecionada!.month.toString())
          .doc(dataHoraFormatadaSalvar.toString())
          .get();
      if (documento.exists) {
        if (context.mounted) {
          _mensagemErro(context, texto: 'Atividade já registrada!\nVerifique a data e horário.');
          alterarCarregando();
          FocusScope.of(context).unfocus();
        }
      } else {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .collection('atividades')
            .doc(dataHoraSelecionada!.year.toString())
            .collection(dataHoraSelecionada!.month.toString())
            .doc(dataHoraFormatadaSalvar.toString())
            .set(modeloDeAtividade.toJson());
        if (context.mounted) {
          _mensagemSucesso(context, texto: 'Atividade registrada com sucesso!');
          alterarCarregando();
          FocusScope.of(context).unfocus();
        }
      }
    } else {
      _mensagemErro(context, texto: 'Algo deu errado');
    }
  }

  int transformarEmMinutos({required TimeOfDay tempo}) {
    int horas = tempo.hour * 60;
    return tempoMinutos = horas + tempo.minute;
  }

  // Mensagem erro
  Future<void> _mensagemErro(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: texto,
      ),
    );
  }

  // Mensagem sucesso
  Future<void> _mensagemSucesso(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: texto,
      ),
    );
  }

  alterarCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
