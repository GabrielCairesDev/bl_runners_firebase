import 'package:cloud_firestore/cloud_firestore.dart';

class ModeloDeUsuario {
  final String id, nome, email, fotoUrl, genero;
  final bool master, admin, autorizado, cadastroConcluido;
  final DateTime dataNascimento;

  ModeloDeUsuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.fotoUrl,
    required this.genero,
    required this.master,
    required this.admin,
    required this.autorizado,
    required this.cadastroConcluido,
    required this.dataNascimento,
  });

  factory ModeloDeUsuario.fromJson(Map<String, dynamic> json) {
    return ModeloDeUsuario(
      id: json['id'] ?? 'Id desconhecida',
      nome: json['nome'] ?? 'Nome Desconhecido',
      email: json['email'] ?? 'Email Desconhecido',
      fotoUrl: json['fotoUrl'] ?? '',
      genero: json['genero'] ?? 'Genero Desconhecido',
      master: json['master'] ?? false,
      admin: json['admin'] ?? false,
      autorizado: json['autorizado'] ?? false,
      cadastroConcluido: json['cadastroConcluido'] ?? false,
      dataNascimento: json['dataNascimento'] != null ? (json['dataNascimento'] as Timestamp).toDate() : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'fotoUrl': fotoUrl,
      'genero': genero,
      'master': master,
      'admin': admin,
      'autorizado': autorizado,
      'cadastroConcluido': cadastroConcluido,
      'dataNascimento': dataNascimento,
    };
  }
}
