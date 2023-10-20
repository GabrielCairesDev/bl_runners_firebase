import 'package:bl_runners_firebase/pages/j_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class PaginaRegistrarCampoDistancia extends StatefulWidget {
  const PaginaRegistrarCampoDistancia({super.key, required this.controlador});

  final PaginaRegistrarAtividadeControlador controlador;

  @override
  State<PaginaRegistrarCampoDistancia> createState() => _PaginaRegistrarCampoDistanciaState();
}

class _PaginaRegistrarCampoDistanciaState extends State<PaginaRegistrarCampoDistancia> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFc1d22b),
                  width: 2,
                )),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              child: Column(
                children: [
                  const Text(
                    'Selecionar distância',
                    style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  NumberPicker(
                    value: widget.controlador.controladorDistancia,
                    minValue: 100,
                    maxValue: 42000,
                    step: 100,
                    itemHeight: 100,
                    axis: Axis.horizontal,
                    textStyle: const TextStyle(color: Colors.blueGrey),
                    selectedTextStyle: const TextStyle(
                      color: Color(0xFFc1d22b),
                      fontSize: 25.0,
                      fontStyle: FontStyle.italic,
                    ),
                    onChanged: (value) => setState(() => widget.controlador.controladorDistancia = value),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: const Color(0xFFc1d22b),
                        width: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
