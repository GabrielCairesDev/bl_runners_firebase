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

  final globalKeyCampoTitulo = GlobalKey<FormState>();
  final globalKeyCampoDescricao = GlobalKey<FormState>();
  final globalKeyCampoData = GlobalKey<FormState>();
  final globalKeyCampoTempo = GlobalKey<FormState>();
  final globalKeyCampoTipo = GlobalKey<FormState>();

  DateTime? pegarData;
  DateTime? dataHoraSelecionada;
  String? dataHoraFormatada;
  TimeOfDay? tempo;
  int? tempoMinutos;
  int controladorDistancia = 5000;

  String? validadorTitulo(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;
  String? validadorDescricao(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;
  String? validadorData(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;

  String? validadorTempo(value) {
    if (value == null || tempo == null) {
      return 'Campo Obrigatório';
    } else if (tempo!.minute < 1 && tempo!.hour < 1) {
      return 'Tempo Inválido';
    }
    return null;
  }

  String? validadorTipo(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;

  validar(context) {
    if (globalKeyCampoTitulo.currentState!.validate() &&
        globalKeyCampoDescricao.currentState!.validate() &&
        globalKeyCampoData.currentState!.validate() &&
        globalKeyCampoTempo.currentState!.validate() &&
        globalKeyCampoTipo.currentState!.validate()) {
      salvar(context);
    }
  }

  salvar(BuildContext context) async {
    // Pegar usuário
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final modeloDeAtividade = ModeloDeAtividade(
        titulo: controladorCampoTitulo.text,
        descricao: controladorCampoDescricao.text,
        tipo: controladorCampoTipo.text,
        tempo: tempoMinutos as int,
        distancia: controladorDistancia,
        dataAtividade: pegarData as DateTime,
      );

      final documento = await FirebaseFirestore.instance
          .collection('usuariosPerfil')
          .doc(user.uid)
          .collection('todasAtividades')
          .doc(dataHoraSelecionada.toString())
          .get();
      if (documento.exists) {
        if (context.mounted) _mensagemErro(context, texto: 'Atividade já registrada!\nVerifique a data e horário.');
      } else {
        await FirebaseFirestore.instance
            .collection('usuariosPerfil')
            .doc(user.uid)
            .collection('todasAtividades')
            .doc(dataHoraSelecionada.toString())
            .set(modeloDeAtividade.toJson());
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
}
