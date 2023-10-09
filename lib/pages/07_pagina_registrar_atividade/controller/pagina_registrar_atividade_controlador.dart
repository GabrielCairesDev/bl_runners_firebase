import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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

  Future<String> registrarAtividade({required String? idUsuario}) async {
    final internet = await Connectivity().checkConnectivity();

    if (internet == ConnectivityResult.none) throw 'Sem conexão com a internet!';
    if (idUsuario == null || idUsuario.isEmpty) throw 'Usuário vázio ou Null!';

    if (globalKeyRegistrarAtividade.currentState!.validate()) {
      final modeloDeAtividade = ModeloDeAtividade(
        idAtividade: '',
        idUsuario: 'idUsuario',
        tipo: controladorCampoTipo.text,
        tempo: tempoMinutos as int,
        distancia: controladorDistancia,
        dataAtividade: dataHoraSelecionada as DateTime,
        ano: dataHoraSelecionada!.year.toInt(),
        mes: dataHoraSelecionada!.month.toInt(),
      );
      altualizarEstadoCarregando();
      try {
        final resultado = await registrarAtividadeUserCase(modeloDeAtividade);
        resetarValores();
        return resultado;
      } catch (e) {
        rethrow;
      } finally {
        altualizarEstadoCarregando();
      }
    }

    throw 'Preencha todos o dados!';
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

  altualizarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
