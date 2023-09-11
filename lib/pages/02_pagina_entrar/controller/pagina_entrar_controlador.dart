import 'package:bl_runners_firebase/providers/auth_provider.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaEntrarControlador extends ChangeNotifier {
  final controladorEmail = TextEditingController(text: 'gabriel.araujo.caires@gmail.com');
  final controladorSenha = TextEditingController(text: 'gabriel');
  final controladorEmailRecuperar = TextEditingController();

  final GlobalKey<FormState> globalKeyEmailPaginaEntrar = GlobalKey<FormState>();

  bool esconderSenha = true;
  bool entradaAutomatica = false;
  bool carregando = false;

  String? validadorEmail(String? value) {
    final regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value!.isEmpty) {
      return 'Campo obrigatório!';
    } else if (!regExp.hasMatch(value)) {
      return 'E-mail invalido!';
    }
    return null;
  }

  String? validadorSenha(String? value) {
    if (value!.isEmpty) {
      return 'Campo obrigatório!';
    }
    return null;
  }

  validarCampos(context) {
    if (globalKeyEmailPaginaEntrar.currentState!.validate() && carregando == false) entrar(context);
  }

  entrar(context) {
    final authprovider = Provider.of<AuthProvider>(context, listen: false);

    atualizarCarregando();

    authprovider.entrar(
      context,
      email: controladorEmail.text.trim(),
      senha: controladorSenha.text.trim(),
      entradaAutomatica: entradaAutomatica,
    );
  }

  recuperarConta(BuildContext context) {
    final controladorAuthprovider = Provider.of<AuthProvider>(context, listen: false);
    Mensagens.caixaDialogoDigitarEmail(
      context,
      email: controladorEmailRecuperar,
      titulo: 'Digite o seu e-mail',
      textoBotaocancelar: 'Cancelar',
      textoBotaoEnviar: 'Enviar',
      onPressedCancelar: () => Navigator.of(context).pop(),
      onPressedEnviar: () => controladorAuthprovider.recuprarConta(context, email: controladorEmailRecuperar.text),
    );
  }

  resetarValores() {
    controladorEmail.clear();
    controladorSenha.clear();
    esconderSenha = true;
    entradaAutomatica = false;
  }

  atualizarCarregando() {
    carregando = !carregando;
    notifyListeners();
  }
}
