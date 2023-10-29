import 'package:flutter/foundation.dart';
import 'package:ntp/ntp.dart';

enum ChecarHorarioResultado { horarioCorreto, horarioDiferente, horarioErro }

class CompararRelogioLocal {
  Future<ChecarHorarioResultado> comparar() async {
    List<String> servidores = [
      '0.br.pool.ntp.org',
      '1.br.pool.ntp.org',
      '2.br.pool.ntp.org',
      '3.br.pool.ntp.org',
    ];

    int diferencaMinutos = 3;

    ChecarHorarioResultado resultado = ChecarHorarioResultado.horarioErro;

    for (String servidor in servidores) {
      try {
        DateTime horarioDipositivo = DateTime.now();
        final int offset = await NTP.getNtpOffset(
            localTime: horarioDipositivo, lookUpAddress: servidor);
        DateTime horarioServidor =
            horarioDipositivo.add(Duration(milliseconds: offset));

        final int diferenca =
            horarioDipositivo.difference(horarioServidor).inMinutes;
        if (diferenca > diferencaMinutos || diferenca < -diferencaMinutos) {
          resultado = ChecarHorarioResultado.horarioDiferente;
          debugPrint(
              'Servidor: $servidor | Horário Servidor: $horarioServidor | Horário Dispositivo: $horarioDipositivo');
          debugPrint('Diferença de tempo em minutos: $diferenca');
          break;
        } else {
          resultado = ChecarHorarioResultado.horarioCorreto;
          debugPrint(
              'Servidor: $servidor | Horário Servidor: $horarioServidor | Horário Dispositivo: $horarioDipositivo');
          debugPrint('Diferença aceita: $diferenca');
          break;
        }
      } catch (e) {
        debugPrint('Erro: $e');
      }
    }

    if (resultado == ChecarHorarioResultado.horarioErro) {
      debugPrint('Todos os servidores estão com problemas!');
    }

    return resultado;
  }
}
