import 'package:cloud_firestore/cloud_firestore.dart';

class ModeloDeUsuario {
  final String? id, nome, fotoUrl, genero;
  final bool? master, admin, convidado, autorizado, cadastroConcluido;
  final DateTime? dataMascimento;

  ModeloDeUsuario({
    this.id,
    this.nome,
    this.fotoUrl,
    this.genero,
    this.master,
    this.admin,
    this.convidado,
    this.autorizado,
    this.cadastroConcluido,
    this.dataMascimento,
  });

  ModeloDeUsuario.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as String? ?? 'Id desconhecida',
          nome: json['nome'] as String? ?? 'Nome Desconhecido',
          fotoUrl: json['fotoUrl'] as String? ??
              'https://firebasestorage.googleapis.com/v0/b/blrunners-app.appspot.com/o/perfil_fotos%2Fnull.png?alt=media&token=fa36029c-bc6c-44fb-b551-7ea229d6cdb0',
          genero: json['genero'] as String? ?? 'Genero Desconhecido',
          master: json['master'] as bool? ?? false,
          admin: json['admin'] as bool? ?? false,
          convidado: json['convidado'] as bool? ?? false,
          autorizado: json['autorizado'] as bool? ?? false,
          cadastroConcluido: json['cadastroConcluido'] as bool? ?? false,
          dataMascimento: json['dataMascimento'] != null ? (json['dataMascimento'] as Timestamp).toDate() : DateTime.now(),
        );

  Map<String, Object?> toJson() {
    return {
      'id': id ?? 'Id desconhecida',
      'nome': nome ?? 'Nome Desconhecido',
      'fotoUrl': fotoUrl ?? 'https://firebasestorage.googleapis.com/v0/b/blrunners-app.appspot.com/o/perfil_fotos%2Fnull.png?alt=media&token=fa36029c-bc6c-44fb-b551-7ea229d6cdb0',
      'genero': genero ?? 'Genero Desconhecido',
      'master': master ?? false,
      'admin': admin ?? false,
      'convidado': convidado ?? false,
      'autorizado': autorizado ?? false,
      'cadastroConcluido': cadastroConcluido ?? false,
      'dataMascimento': dataMascimento != null ? Timestamp.fromDate(dataMascimento!) : DateTime.now(),
    };
  }
}
