import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Mensagens {
  static void caixaDeDialogoSimNao(
    BuildContext context, {
    required String titulo,
    required String texto,
    required String textoBotaoSim,
    required String textoBotaoNao,
    required Function()? onPressedSim,
    required Function()? onPressedNao,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            title: Text(titulo, textAlign: TextAlign.center),
            content: Text(texto, textAlign: TextAlign.center),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onPressedSim,
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                      child: Text(
                        textoBotaoSim,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onPressedNao,
                        child: Text(
                          textoBotaoNao,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void caixaDialogoDigitarSenha(
    BuildContext context, {
    required TextEditingController escrever,
    required String titulo,
    // required String texto,
    required String textoBotaoExcluir,
    required String textoBotaoCancelar,
    required Function()? onPressedExcluir,
    required Function()? onPressedCancelar,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            title: Text(titulo, textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const Text("Digite sua senha atual para confirmar a exclusão."),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: escrever,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Digite sua senha",
                    hintText: "Digite sua senha",
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: onPressedExcluir,
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                child: Text(textoBotaoExcluir),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: onPressedCancelar,
                  child: Text(textoBotaoCancelar),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static mensagemSucesso(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: texto),
    );
  }

  static mensagemErro(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: texto),
    );
  }

  static mensagemInfo(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(backgroundColor: Colors.orange, message: texto),
      snackBarPosition: SnackBarPosition.bottom,
    );
  }
}
