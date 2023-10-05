extension DataFormatadaExtension on DateTime {
  String extenso(int mes) {
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

  String get dataFormatada {
    int dia = day;
    int mes = month;
    int ano = year;
    int hora = hour;
    int minuto = minute;

    String horaFormatada = hora.toString();
    if (hora < 10) {
      horaFormatada = '0$hora';
    }

    String minutoFormatado = minuto.toString();
    if (minuto < 10) {
      minutoFormatado = '0$minuto';
    }

    return '$dia de ${extenso(mes)} de $ano às $horaFormatada:$minutoFormatado';
  }
}
