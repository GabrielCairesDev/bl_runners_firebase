class Utilitarios {
  String calcularRitmo(int? metros, int? segundos) {
    if (metros == null || metros == 0 || segundos == null || segundos == 0) {
      return '00:00/km';
    }

    double quilometros = metros / 1000.0;
    double ritmoSegundos = segundos / quilometros;

    if (ritmoSegundos.isInfinite || ritmoSegundos.isNaN) {
      return '00:00/km';
    }

    int minutosInteiros = ritmoSegundos ~/ 60;
    int segundosInteiros = (ritmoSegundos % 60).toInt();

    String resultado =
        '${minutosInteiros.toString().padLeft(2, '0')}:${segundosInteiros.toString().padLeft(2, '0')} /km';
    return resultado;
  }

  String formatarTempo(int? segundos) {
    if (segundos == null) {
      return '0h 0min';
    } else {
      int horas = segundos ~/ 3600;
      int minutos = (segundos % 3600) ~/ 60;
      return '${horas}h ${minutos}min';
    }
  }

  String extensoMesAno(int mes) {
    switch (mes) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
      default:
        return 'Mês Inválido';
    }
  }

  String mesAnoPorExtenso(int mes, int ano) {
    return '${extensoMesAno(mes)} de $ano';
  }
}
