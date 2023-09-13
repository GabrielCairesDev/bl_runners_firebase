import 'package:bl_runners_firebase/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final controladorDataProvider = Provider.of<DataProvider>(context, listen: false);
    if (globalKeyRegistrarAtividade.currentState!.validate()) {
      controladorDataProvider.registrarAtividade(context);
    }
  }

  int transformarEmMinutos({required TimeOfDay tempo}) {
    int horas = tempo.hour * 60;
    return tempoMinutos = horas + tempo.minute;
  }

  // Apagar Valores
  resetarValores() {
    controladorCampoTitulo.clear();
    controladorCampoDescricao.clear();
    controladorCampoData.clear();
    controladorCampoTempo.clear();
    controladorCampoTipo.clear();
    controladorDistancia = 5000;
    tempo = const TimeOfDay(hour: 0, minute: 0);
  }

  alterarCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
