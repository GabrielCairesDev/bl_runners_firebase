import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PaginaRegistrarTipo extends StatefulWidget {
  const PaginaRegistrarTipo({super.key});

  @override
  State<PaginaRegistrarTipo> createState() => _PaginaRegistrarTipoState();
}

class _PaginaRegistrarTipoState extends State<PaginaRegistrarTipo> {
  final List<String> tipos = ['Treino', 'Prova'];
  String? tipoSelecionado;

  @override
  Widget build(BuildContext context) {
    final controladorPaginaRegistrarAtividade = Provider.of<PaginaRegistrarAtividadeControlador>(context);
    return TextFormField(
      readOnly: true,
      validator: controladorPaginaRegistrarAtividade.validadorTipo,
      controller: controladorPaginaRegistrarAtividade.controladorCampoTipo,
      decoration: const InputDecoration(
        filled: false,
        prefixIcon: Icon(Icons.list_alt),
        border: OutlineInputBorder(),
        hintText: 'Tipo',
        suffixIcon: Icon(Icons.expand_more),
      ),
      onTap: () async {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Selecionar tipo',
                        style: TextStyle(fontSize: 25, color: Colors.blueGrey),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: const Color(0xFFc1d22b),
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Treino',
                            style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      onTap: () => setState(() {
                        controladorPaginaRegistrarAtividade.controladorCampoTipo.text = 'Treino';
                        context.pop(context);
                      }),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    InkWell(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: const Color(0xFFc1d22b),
                            width: 2,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Prova',
                            style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      onTap: () => setState(() {
                        controladorPaginaRegistrarAtividade.controladorCampoTipo.text = 'Prova';
                        context.pop(context);
                      }),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
