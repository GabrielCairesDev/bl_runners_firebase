import 'dart:ui';

import 'package:flutter/material.dart';

class Mensagens {
  static void snackBar(BuildContext context, String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  static void caixaDeDialogo(
    BuildContext context, {
    required String titulo,
    required String texto,
    required String textoBotao,
    required Function()? onPressed,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            title: Text(titulo, textAlign: TextAlign.center),
            content: Text(texto),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    textoBotao,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            title: Text(titulo, textAlign: TextAlign.center),
            content: Text(texto),
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
                    ElevatedButton(
                      onPressed: onPressedNao,
                      child: Text(
                        textoBotaoNao,
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
}
