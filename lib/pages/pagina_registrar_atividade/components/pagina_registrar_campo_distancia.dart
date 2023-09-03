import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class PaginaRegistrarCampoDistancia extends StatefulWidget {
  const PaginaRegistrarCampoDistancia({super.key});

  @override
  State<PaginaRegistrarCampoDistancia> createState() => _PaginaRegistrarCampoDistanciaState();
}

class _PaginaRegistrarCampoDistanciaState extends State<PaginaRegistrarCampoDistancia> {
  TextEditingController controlador = TextEditingController(text: 'Distância');
  int _distancia = 5000;
  @override
  Widget build(BuildContext context) {
    return Form(
      //  key: controlador.globalKeyCampoDistancia,
      child: Column(
        children: [
          // TextFormField(
          //   readOnly: true,
          //   //  validator: controlador.validadorDistancia,
          //   controller: controlador,
          //   decoration: InputDecoration(
          //     filled: false,
          //     prefixIcon: const Icon(Icons.location_on),
          //     border: const OutlineInputBorder(),
          //     hintText: controlador.text,
          //   ),
          //   onTap: () => {},
          // ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFc1d22b),
                  width: 2,
                )),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 24, left: 24, bottom: 24),
              child: Column(
                children: [
                  const Text(
                    'Selecionar distância',
                    style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  NumberPicker(
                    value: _distancia,
                    minValue: 100,
                    maxValue: 42000,
                    step: 100,
                    itemHeight: 100,
                    axis: Axis.horizontal,
                    textStyle: const TextStyle(color: Colors.blueGrey),
                    selectedTextStyle: const TextStyle(
                      color: Color(0xFFc1d22b),
                      fontSize: 25.0,
                    ),
                    onChanged: (value) => setState(() {
                      _distancia = value;
                      controlador.text = '${_distancia.toString()} Metros';
                    }),
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
