import 'package:cloud_firestore/cloud_firestore.dart';

class ModeloDeUsuario {
  final String? genero;
  final bool? master, admin, convidado, autorizado, cadastroConcluido;
  final DateTime? dataMascimento;

  ModeloDeUsuario({
    this.genero,
    this.master,
    this.admin,
    this.convidado,
    this.autorizado,
    this.cadastroConcluido,
    this.dataMascimento,
  });

  Map<String, dynamic> toMap() {
    return {
      'genero': genero,
      'master': master,
      'admin': admin,
      'convidado': convidado,
      'autorizado': autorizado,
      'cadastroConcluido': cadastroConcluido,
      'dataMascimento': dataMascimento != null ? Timestamp.fromDate(dataMascimento!) : null,
    };
  }

  factory ModeloDeUsuario.fromMap(Map<String, dynamic> map) {
    return ModeloDeUsuario(
      genero: map['genero'] ?? '',
      master: map['master'] ?? false,
      admin: map['admin'] ?? false,
      convidado: map['convidado'] ?? false,
      autorizado: map['autorizado'] ?? false,
      cadastroConcluido: map['cadastroConcluido'] ?? false,
      dataMascimento: map['dataMascimento'] != null ? (map['dataMascimento'] as Timestamp).toDate() : DateTime.now(),
    );
  }
}
