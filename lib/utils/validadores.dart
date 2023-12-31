class Validador {
  static String? email(String? value) {
    final regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value!.isEmpty) {
      return 'Digite o e-mail';
    } else if (!regExp.hasMatch(value)) {
      return 'E-mail invalido!';
    } else if (value.contains(' ')) {
      return 'E-mail não pode conter espaços';
    } else if (value.length < 10) {
      return 'E-mail muito curto';
    } else if (value.length > 50) {
      return 'E-mail muito longo';
    }
    return null;
  }

  static String? senha(String? value) {
    if (value!.isEmpty) {
      return 'Digite a senha';
    } else if (value.length < 6) {
      return 'Senha muito curta';
    } else if (value.contains(' ')) {
      return 'Senha não pode conter espaços';
    }
    return null;
  }

  static String? nome(String? value) {
    if (value!.isEmpty) {
      return 'Digite o nome';
    } else if (value.length < 3) {
      return 'Nome muito curto';
    } else if (value.length > 25) {
      return 'Nome muito longo';
    } else if (value.contains(RegExp(r'[0-9]'))) {
      return 'Nome não pode conter números';
    }
    return null;
  }

  static String? nascimento(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  static String? genero(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  static String? foto(String? value) => value!.isEmpty ? 'Campo obrigatório*' : null;
  static String? titulo(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;
  static String? descricao(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;
  static String? data(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;
  static String? tipo(String? value) => value!.isEmpty ? 'Campo Obrigatório' : null;
}
