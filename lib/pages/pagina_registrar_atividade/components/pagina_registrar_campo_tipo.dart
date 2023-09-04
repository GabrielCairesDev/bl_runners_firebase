import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarTipo extends StatefulWidget {
  const PaginaRegistrarTipo({super.key});

  @override
  State<PaginaRegistrarTipo> createState() => _PaginaRegistrarTipoState();
}

class _PaginaRegistrarTipoState extends State<PaginaRegistrarTipo> {
  final tipo = ['Treino', 'Prova'];

  @override
  Widget build(BuildContext context) {
    final controlador = context.read<PaginaRegistrarAtividadeControlador>();
    return Form(
      key: controlador.globalKeyCampoTipo,
      child: DropdownButtonFormField(
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
        decoration: const InputDecoration(
          filled: false,
          prefixIcon: Icon(Icons.format_list_bulleted),
          border: OutlineInputBorder(),
          hintText: 'Tipo',
        ),
        isExpanded: true,
        isDense: true,
        value: controlador.controladorCampoTipo,
        selectedItemBuilder: (BuildContext context) {
          return tipo
              .map<Widget>(
                (String texto) => DropdownMenuItem(
                  value: texto,
                  child: Text(
                    texto,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              )
              .toList();
        },
        items: tipo.map(
          (generoEscolhido) {
            if (generoEscolhido == controlador.controladorCampoTipo) {
              return DropdownMenuItem(
                value: generoEscolhido,
                child: Container(
                  height: 70.0,
                  color: Colors.grey.withOpacity(0.1),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(generoEscolhido, style: const TextStyle(color: Colors.black)),
                  ),
                ),
              );
            } else {
              return DropdownMenuItem(
                value: generoEscolhido,
                child: Text(generoEscolhido, style: const TextStyle(color: Colors.black)),
              );
            }
          },
        ).toList(),
        //  validator: controlador.validadorTipo,
        onChanged: (valor) => setState(
          () {
            if (valor != controlador.controladorCampoTipo) {
              controlador.controladorCampoTipo = valor.toString();
            }
          },
        ),
      ),
    );
  }
}
