class ModeloDeAtividade {
  final String titulo, descricao, tipo, idUsuario;
  final int tempo, distancia, ano, mes;
  final DateTime dataAtividade;

  ModeloDeAtividade({
    required this.idUsuario,
    required this.titulo,
    required this.descricao,
    required this.tipo,
    required this.tempo,
    required this.distancia,
    required this.dataAtividade,
    required this.ano,
    required this.mes,
  });

  factory ModeloDeAtividade.fromJson(Map<String, dynamic> json) {
    return ModeloDeAtividade(
      idUsuario: json['idUsuario'] ?? '',
      titulo: json['titulo'] ?? 'Sem Titulo',
      descricao: json['descricao'] ?? 'Sem Descrição',
      tipo: json['tipo'] ?? 'Treino',
      tempo: json['tempo'] ?? 0,
      distancia: json['distancia'] ?? 0,
      dataAtividade: json['dataAtividade'] != null ? DateTime.parse((json['dataAtividade'])) : DateTime.now(),
      ano: json['ano'] ?? 0,
      mes: json['mes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'titulo': titulo,
      'descricao': descricao,
      'tipo': tipo,
      'tempo': tempo,
      'distancia': distancia,
      'dataAtividade': dataAtividade.toIso8601String(),
      'ano': ano,
      'mes': mes,
    };
  }

  ModeloDeAtividade copyWith({
    String? titulo,
    String? descricao,
    String? tipo,
    String? idUsuario,
    int? tempo,
    int? distancia,
    int? ano,
    int? mes,
    DateTime? dataAtividade,
  }) {
    return ModeloDeAtividade(
      idUsuario: idUsuario ?? this.idUsuario,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      tipo: tipo ?? this.tipo,
      tempo: tempo ?? this.tempo,
      distancia: distancia ?? this.distancia,
      dataAtividade: dataAtividade ?? this.dataAtividade,
      ano: ano ?? this.ano,
      mes: mes ?? this.mes,
    );
  }
}
