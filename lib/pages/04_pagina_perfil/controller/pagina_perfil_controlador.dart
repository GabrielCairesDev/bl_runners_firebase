import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/models/modelo_de_atividade.dart';
import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_id_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_usuarios_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/sair_use_case.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaPerfilControlador extends ChangeNotifier {
  PaginaPerfilControlador({
    required this.sairUseCase,
    required this.pegarAtividadesIdUsuarioUseCase,
    required this.pegarUsuariosUseCase,
  });

  final SairUseCase sairUseCase;
  final PegarUsuariosUseCase pegarUsuariosUseCase;
  final PegarAtividadesIdUsuarioUseCase pegarAtividadesIdUsuarioUseCase;

  late List<ModeloDeAtividade> listaAtividades = [];
  late List<ModeloDeUsuario> listaUsuarios = [];

  bool carregando = false;
  bool carregadoInitState = false;
  String idUsuario = '';

  Future<void> carregarAtividades() async {
    listaAtividades.clear();
    listaUsuarios.clear();

    final modeloDeAtividade = ModeloDeAtividade(
      idAtividade: '',
      idUsuario: '',
      tipo: '',
      tempo: 0,
      distancia: 0,
      dataAtividade: DateTime.now(),
      ano: 0,
      mes: 0,
    );

    final modeloDeUsuario = ModeloDeUsuario(
      id: '',
      nome: '',
      email: '',
      fotoUrl: '',
      genero: 'Masculino',
      master: false,
      admin: false,
      autorizado: false,
      cadastroConcluido: false,
      dataNascimento: DateTime.now(),
    );

    try {
      alterarEstadoCarregando();

      final resultadoAtividades = await pegarAtividadesIdUsuarioUseCase(modeloDeAtividade, idUsuario);
      listaAtividades = resultadoAtividades;

      final resultadoUsuarios = await pegarUsuariosUseCase(modeloDeUsuario, listaAtividades);
      listaUsuarios = resultadoUsuarios;

      listaAtividades.sort((atividade1, atividade2) => atividade2.dataAtividade.compareTo(atividade1.dataAtividade));
    } catch (e) {
      logger.d(e);
    } finally {
      notifyListeners();
      alterarEstadoCarregando();
    }
  }

  Future<String> sair() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final resultado = await sairUseCase();
      prefs.setBool("entrarAutomaticamente", false);
      return resultado;
    } catch (e) {
      throw 'Erro ao tentar sair: $e!';
    }
  }

  alterarEstadoCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
