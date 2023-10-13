import 'package:bl_runners_firebase/pages/04_pagina_perfil/controller/pagina_perfil_controlador.dart';
import 'package:bl_runners_firebase/utils/utilitarios.dart';
import 'package:flutter/material.dart';

class PaginaPerfilRecordes extends StatelessWidget {
  const PaginaPerfilRecordes({
    super.key,
    required this.controladorPaginaPerfil,
  });

  final PaginaPerfilControlador controladorPaginaPerfil;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.25,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Distância',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.040,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              Text(
                '${controladorPaginaPerfil.listaDeAtividadesSomadas.isNotEmpty ? controladorPaginaPerfil.listaDeAtividadesSomadas[0].distancia / 1000 : 0} km',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.065,
                  color: const Color(0xFFc1d22b),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ritmo',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.040,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              Text(
                Utilidarios().calcularRitmo(
                    controladorPaginaPerfil.listaDeAtividadesSomadas.isNotEmpty
                        ? controladorPaginaPerfil.listaDeAtividadesSomadas[0].distancia
                        : 0,
                    controladorPaginaPerfil.listaDeAtividadesSomadas.isNotEmpty
                        ? controladorPaginaPerfil.listaDeAtividadesSomadas[0].tempo
                        : 0),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.065,
                  color: const Color(0xFFc1d22b),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Atividades',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.040,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              Text(
                controladorPaginaPerfil.listaDeAtividades.isNotEmpty ? controladorPaginaPerfil.listaDeAtividades.length.toString() : '0',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.065,
                  color: const Color(0xFFc1d22b),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
