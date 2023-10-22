class ModeloDeAtividade {
  final String tipo, idAtividade, idUsuario;
  final int tempo, distancia, ano, mes;
  final String dataAtividade;

  ModeloDeAtividade({
    required this.idAtividade,
    required this.idUsuario,
    required this.tipo,
    required this.tempo,
    required this.distancia,
    required this.dataAtividade,
    required this.ano,
    required this.mes,
  });

  factory ModeloDeAtividade.fromJson(Map<String, dynamic> json) {
    return ModeloDeAtividade(
      idAtividade: json['idAtividade'] ?? '',
      idUsuario: json['idUsuario'] ?? '',
      tipo: json['tipo'] ?? 'Treino',
      tempo: json['tempo'] ?? 0,
      distancia: json['distancia'] ?? 0,
      dataAtividade: json['dataAtividade'] ?? '2000-10-10 01:00:00',
      ano: json['ano'] ?? 0,
      mes: json['mes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idAtividade': idAtividade,
      'idUsuario': idUsuario,
      'tipo': tipo,
      'tempo': tempo,
      'distancia': distancia,
      'dataAtividade': dataAtividade,
      'ano': ano,
      'mes': mes,
    };
  }

  ModeloDeAtividade copyWith({
    String? tipo,
    String? idAtividade,
    String? idUsuario,
    int? tempo,
    int? distancia,
    int? ano,
    int? mes,
    String? dataAtividade,
  }) {
    return ModeloDeAtividade(
      idAtividade: idAtividade ?? this.idAtividade,
      idUsuario: idUsuario ?? this.idUsuario,
      tipo: tipo ?? this.tipo,
      tempo: tempo ?? this.tempo,
      distancia: distancia ?? this.distancia,
      dataAtividade: dataAtividade ?? this.dataAtividade,
      ano: ano ?? this.ano,
      mes: mes ?? this.mes,
    );
  }
}
