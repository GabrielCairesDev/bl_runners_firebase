import 'package:flutter/material.dart';

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

  TimeOfDay? tempo;
  int distancia = 5000;

  String? validadorTitulo(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;
  String? validadorDescricao(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;
  String? validadorData(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;

  String? validadorTempo(value) {
    if (value == null || tempo == null || tempo!.minute < 1) {
      return 'Campo Obrigatório';
    } else {
      return null;
    }
  }

  String? validadorTipo(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;

  validar() {
    if (globalKeyCampoTitulo.currentState!.validate() &&
        globalKeyCampoDescricao.currentState!.validate() &&
        globalKeyCampoData.currentState!.validate() &&
        globalKeyCampoTempo.currentState!.validate() &&
        globalKeyCampoTipo.currentState!.validate()) {}
  }
}
