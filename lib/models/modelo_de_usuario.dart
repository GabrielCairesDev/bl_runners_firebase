import 'package:cloud_firestore/cloud_firestore.dart';

class ModeloDeUsuario {
  final String? genero, camiseta;
  final bool? master, admin, convidado, autorizado, cadastroConcluido;
  final int? tenis;
  final DateTime? dataMascimento;

  ModeloDeUsuario({
    this.genero,
    this.camiseta,
    this.master,
    this.admin,
    this.convidado,
    this.autorizado,
    this.cadastroConcluido,
    this.tenis,
    this.dataMascimento,
  });

  Map<String, dynamic> toMap() {
    return {
      'genero': genero,
      'camiseta': camiseta,
      'master': master,
      'admin': admin,
      'convidado': convidado,
      'autorizado': autorizado,
      'cadastroConcluido': cadastroConcluido,
      'tenis': tenis,
      'dataMascimento': dataMascimento != null ? Timestamp.fromDate(dataMascimento!) : null,
    };
  }

  factory ModeloDeUsuario.fromMap(Map<String, dynamic> map) {
    return ModeloDeUsuario(
      genero: map['genero'] ?? '',
      camiseta: map['camiseta'] ?? '',
      master: map['master'] ?? false,
      admin: map['admin'] ?? false,
      convidado: map['convidado'] ?? false,
      autorizado: map['autorizado'] ?? false,
      cadastroConcluido: map['cadastroConcluido'] ?? false,
      tenis: map['tenis'] ?? 0,
      dataMascimento: map['dataMascimento'] != null ? (map['dataMascimento'] as Timestamp).toDate() : DateTime.now(),
    );
  }
}
