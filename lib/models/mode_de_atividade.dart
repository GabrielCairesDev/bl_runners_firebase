import 'package:cloud_firestore/cloud_firestore.dart';

class ModeloDeAtividade {
  final String titulo, descricao, tipo, id;
  final int tempo, distancia;
  final DateTime dataAtividade;

  ModeloDeAtividade({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.tipo,
    required this.tempo,
    required this.distancia,
    required this.dataAtividade,
  });

  factory ModeloDeAtividade.fromJson(Map<String, dynamic> json) {
    return ModeloDeAtividade(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? 'Sem Titulo',
      descricao: json['descricao'] ?? 'Sem Descrição',
      tipo: json['tipo'] ?? 'Treino',
      tempo: json['tempo'] ?? 0,
      distancia: json['distancia'] ?? 0,
      dataAtividade: json['dataAtividade'] != null ? (json['dataAtividade'] as Timestamp).toDate() : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'tipo': tipo,
      'tempo': tempo,
      'distancia': distancia,
      'dataAtividade': dataAtividade,
    };
  }
}
