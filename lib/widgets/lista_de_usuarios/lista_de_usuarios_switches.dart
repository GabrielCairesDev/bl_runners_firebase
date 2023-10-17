import 'package:flutter/material.dart';

class ListaDeUsuariosSwitches extends StatelessWidget {
  const ListaDeUsuariosSwitches({super.key, required this.master, required this.admin, required this.autorizado});

  final bool master;
  final bool admin;
  final bool autorizado;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Switch(
                  value: master,
                  onChanged: (value) {},
                ),
                const Text('Master'),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Switch(
                  value: admin,
                  onChanged: (value) {},
                ),
                const Text('Admin'),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Switch(
                  value: autorizado,
                  onChanged: (value) {},
                ),
                const Text('Autorizado'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
