class Utilitarios {
  String calcularRitmo(int? metros, int? minutos) {
    if (metros == null || metros == 0 || minutos == null || minutos == 0) {
      return '00:00/km';
    }

    double quilometros = metros / 1000.0;
    double ritmoMinutos = minutos / quilometros;

    if (ritmoMinutos.isInfinite || ritmoMinutos.isNaN) {
      return '00:00/km';
    }

    int minutosInteiros = ritmoMinutos.toInt();
    int segundosInteiros = ((ritmoMinutos - minutosInteiros) * 60).toInt();

    String resultado = '${minutosInteiros.toString().padLeft(2, '0')}:${segundosInteiros.toString().padLeft(2, '0')} /km';
    return resultado;
  }

  String formatarTempo(int? minutos) {
    if (minutos == null) {
      return '0h 0min';
    } else {
      int horas = minutos ~/ 60;
      int minutosRestantes = minutos % 60;
      return '${horas}h ${minutosRestantes}min';
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
