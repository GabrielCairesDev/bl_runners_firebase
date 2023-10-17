import 'package:flutter/material.dart';

class ListaDeUsuariosInfos extends StatelessWidget {
  const ListaDeUsuariosInfos({super.key, required this.email, required this.cadastroConcluido});

  final String email;
  final bool cadastroConcluido;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        cadastroConcluido == true
            ? const Text(
                'Cadastro concluído',
                style: TextStyle(color: Colors.green),
              )
            : const Text(
                'Cadastro não concluído',
                style: TextStyle(color: Colors.red),
              ),
        Text(
          email.isNotEmpty ? email : 'E-mail não cadastrado',
          style: TextStyle(
            color: email.isNotEmpty ? Colors.black : Colors.red,
          ),
        ),
      ],
    );
  }
}
