import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RegistrarAtividadeUseCase {
  Future<String> call({
    required String tipo,
    required int tempo,
    required int distancia,
    required Timestamp dataAtividade,
    required int ano,
    required int mes,
  });
}
