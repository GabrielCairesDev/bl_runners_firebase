import 'package:bl_runners_app/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:bl_runners_app/utils/checar_horario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class PaginaRegistrarAtividadeControlador extends ChangeNotifier {
  final RegistrarAtividadeUseCase registrarAtividadeUserCase;

  PaginaRegistrarAtividadeControlador(
      {required this.registrarAtividadeUserCase});

  final TextEditingController controladorCampoTitulo = TextEditingController();
  final TextEditingController controladorCampoDescricao =
      TextEditingController();
  final TextEditingController controladorCampoData = TextEditingController();
  final TextEditingController controladorCampoTempo = TextEditingController();
  final TextEditingController controladorCampoTipo = TextEditingController();

  final GlobalKey<FormState> globalKeyRegistrarAtividade =
      GlobalKey<FormState>();

  Timestamp? dataHoraSelecionada;
  int? tempoSegundos;
  int controladorDistancia = 5000;
  bool carregando = false;

  Future<String> registrarAtividade(
      {required String? idUsuario, required bool usuarioAutorizado}) async {
    final internet = await Connectivity().checkConnectivity();
    final relogioLocal = await CompararRelogioLocal().comparar();

    if (internet == ConnectivityResult.none) {
      throw 'Sem conexão com a internet!';
    }
    if (relogioLocal == ChecarHorarioResultado.horarioDiferente) {
      throw 'Verifique a data e horário do seu dispositivo!';
    }
    if (relogioLocal == ChecarHorarioResultado.horarioErro) {
      throw 'Tente mais tarde!';
    }
    if (idUsuario == null || idUsuario.isEmpty) throw 'Usuário vázio ou Null!';
    if (usuarioAutorizado == false) {
      throw 'Usuário não autorizado!\nEntre em contato com um administrador!';
    }

    if (globalKeyRegistrarAtividade.currentState!.validate()) {
      try {
        _altualizarEstadoCarregando();

        final resultado = await registrarAtividadeUserCase(
          tipo: controladorCampoTipo.text,
          tempo: tempoSegundos as int,
          distancia: controladorDistancia,
          dataAtividade: dataHoraSelecionada ?? Timestamp.now(),
          ano: dataHoraSelecionada?.toDate().year ??
              Timestamp.now().toDate().year,
          mes: dataHoraSelecionada?.toDate().month ??
              Timestamp.now().toDate().month,
        );
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

  _resetarValores() {
    controladorCampoTitulo.clear();
    controladorCampoDescricao.clear();
    controladorCampoData.clear();
    controladorCampoTempo.clear();
    controladorCampoTipo.clear();
    controladorDistancia = 5000;
    tempoSegundos = 0;
  }

  _altualizarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
