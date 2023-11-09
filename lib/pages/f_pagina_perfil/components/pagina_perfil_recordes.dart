import 'package:bl_runners_app/pages/f_pagina_perfil/controller/pagina_perfil_controlador.dart';
import 'package:bl_runners_app/utils/utilitarios.dart';
import 'package:flutter/material.dart';

class PaginaPerfilRecordes extends StatelessWidget {
  const PaginaPerfilRecordes(
      {super.key, required this.controladorPaginaPerfil});

  final PaginaPerfilControlador controladorPaginaPerfil;

  @override
  Widget build(BuildContext context) {
    final lista = controladorPaginaPerfil.listaDeAtividadesSomadas.isNotEmpty
        ? controladorPaginaPerfil.listaDeAtividadesSomadas[0]
        : null;

    final distanciaTotal = lista != null ? lista.distancia / 1000 : 0;
    final ritmoMedio = lista != null
        ? Utilitarios().calcularRitmo(lista.distancia, lista.tempo)
        : '00:00 /km';

    final atividadeTotal = controladorPaginaPerfil.listaDeAtividades.length;

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
                '$distanciaTotal km',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.055,
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
                ritmoMedio.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.055,
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
                atividadeTotal.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.055,
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
