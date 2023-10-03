class Validador {
  static String? email(String? value) {
    final regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value!.isEmpty) {
      return 'E-mail não pode ser vazio';
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
      return 'Senha não pode ser vazia';
    } else if (value.length < 6) {
      return 'Senha deve conter no mínimo 6 caracteres';
    } else if (value.contains(' ')) {
      return 'Senha não pode conter espaços';
    }
    return null;
  }

  static String confirmarSenha(
    String? value,
    String value2,
  ) {
    if (value != value2) {
      return 'Senhas não conferem';
    }
    return '';
  }

  static String? nome(String? value) {
    if (value!.isEmpty) {
      return 'Nome não pode ser vazio';
    } else if (value.length < 3) {
      return 'Nome deve conter no mínimo 3 caracteres';
    } else if (value.length > 15) {
      return 'Nome deve conter no máximo 15 caracteres';
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
