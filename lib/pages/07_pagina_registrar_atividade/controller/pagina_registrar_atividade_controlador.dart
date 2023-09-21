import 'package:bl_runners_firebase/models/mode_de_atividade.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:flutter/material.dart';

class PaginaRegistrarAtividadeControlador extends ChangeNotifier {
  final RegistrarAtividadeUseCase registrarAtividadeUserCase;

  PaginaRegistrarAtividadeControlador({required this.registrarAtividadeUserCase});

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

  Future<bool> registrarAtividade() async {
    if (globalKeyRegistrarAtividade.currentState!.validate()) {
      final modeloDeAtividade = ModeloDeAtividade(
        idUsuario: '',
        titulo: controladorCampoTitulo.text,
        descricao: controladorCampoDescricao.text,
        tipo: controladorCampoTipo.text,
        tempo: tempoMinutos as int,
        distancia: controladorDistancia,
        dataAtividade: dataHoraSelecionada as DateTime,
        ano: dataHoraSelecionada!.year.toInt(),
        mes: dataHoraSelecionada!.month.toInt(),
      );
      return registrarAtividadeUserCase(modeloDeAtividade);
    }

    return false;
  }

  int transformarEmMinutos({required TimeOfDay tempo}) {
    int horas = tempo.hour * 60;
    return tempoMinutos = horas + tempo.minute;
  }

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
