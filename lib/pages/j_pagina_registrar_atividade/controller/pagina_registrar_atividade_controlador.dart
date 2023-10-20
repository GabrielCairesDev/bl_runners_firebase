import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class PaginaRegistrarAtividadeControlador extends ChangeNotifier {
  final RegistrarAtividadeUseCase registrarAtividadeUserCase;

  PaginaRegistrarAtividadeControlador({required this.registrarAtividadeUserCase});

  final TextEditingController controladorCampoTitulo = TextEditingController();
  final TextEditingController controladorCampoDescricao = TextEditingController();
  final TextEditingController controladorCampoData = TextEditingController();
  final TextEditingController controladorCampoTempo = TextEditingController();
  final TextEditingController controladorCampoTipo = TextEditingController();

  final GlobalKey<FormState> globalKeyRegistrarAtividade = GlobalKey<FormState>();

  Timestamp? dataHoraSelecionada;
  String? dataHoraFormatadaSalvar;
  TimeOfDay? tempo;
  int? tempoMinutos;
  int controladorDistancia = 5000;
  bool carregando = false;

  Future<String> registrarAtividade({required String? idUsuario, required bool usuarioAutorizado}) async {
    final internet = await Connectivity().checkConnectivity();

    if (internet == ConnectivityResult.none) throw 'Sem conexão com a internet!';
    if (idUsuario == null || idUsuario.isEmpty) throw 'Usuário vázio ou Null!';
    if (usuarioAutorizado == false) throw 'Usuário não autorizado!\nEntre em contato com um administrador';

    if (globalKeyRegistrarAtividade.currentState!.validate()) {
      final modeloDeAtividade = ModeloDeAtividade(
        idAtividade: '',
        idUsuario: 'idUsuario',
        tipo: controladorCampoTipo.text,
        tempo: tempoMinutos as int,
        distancia: controladorDistancia,
        dataAtividade: dataHoraSelecionada ?? Timestamp.now(),
        ano: dataHoraSelecionada?.toDate().year ?? Timestamp.now().toDate().year,
        mes: dataHoraSelecionada?.toDate().month ?? Timestamp.now().toDate().month,
      );
      _altualizarEstadoCarregando();
      try {
        final resultado = await registrarAtividadeUserCase(modeloDeAtividade);
        _resetarValores();
        return resultado;
      } catch (e) {
        rethrow;
      } finally {
        _altualizarEstadoCarregando();
      }
    }

    throw 'Preencha todos o dados!';
  }

  transformarEmMinutos({required TimeOfDay tempo}) {
    int horas = tempo.hour * 60;
    return tempoMinutos = horas + tempo.minute;
  }

  _resetarValores() {
    controladorCampoTitulo.clear();
    controladorCampoDescricao.clear();
    controladorCampoData.clear();
    controladorCampoTempo.clear();
    controladorCampoTipo.clear();
    controladorDistancia = 5000;
    tempo = const TimeOfDay(hour: 0, minute: 0);
  }

  _altualizarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
