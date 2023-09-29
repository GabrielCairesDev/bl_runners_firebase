import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/pagina_concluir_cadastro_campo_genero.dart';
import '../components/pagina_concluir_cadastro_campo_nome.dart';
import '../components/Pagina_concluir_cadastro_campo_foto.dart';
import '../components/pagina_concluir_cadastro_botao_concluir.dart';

import '../components/pagina_concluir_cadastro_campo_nascimento.dart';
import '../controller/pagina_concluir_cadastro_controlador.dart';

class PaginaConcluirCadastro extends StatelessWidget {
  const PaginaConcluirCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    final controladorPaginaConcluirCadastro = Provider.of<PaginaConcluirCadastroControlador>(context);
    return AbsorbPointer(
      absorbing: controladorPaginaConcluirCadastro.carregando,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Concluir Cadastro'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Form(
                  key: controladorPaginaConcluirCadastro.globalKeyPaginaConcluirCadastro,
                  child: const Column(
                    children: [
                      PaginaConcluirCampoNome(),
                      SizedBox(height: 16),
                      PaginaRegistrarCampoGenero(),
                      SizedBox(height: 16),
                      PaginaConcluirCampoNascimento(),
                      SizedBox(height: 16),
                      PaginaConcluirCampoFoto(),
                      SizedBox(height: 16),
                      PaginaConcluirBotaoConcluir(),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Visibility(
                      visible: controladorPaginaConcluirCadastro.carregando,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
