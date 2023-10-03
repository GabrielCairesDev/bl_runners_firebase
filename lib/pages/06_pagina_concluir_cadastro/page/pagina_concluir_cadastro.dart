import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario.dart';
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
    final controladorConcluirCadastro = Provider.of<PaginaConcluirCadastroControlador>(context);
    final controladorPegarUsuario = Provider.of<PegarUsuario>(context);
    return AbsorbPointer(
      absorbing: controladorConcluirCadastro.carregando,
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
                  key: controladorConcluirCadastro.globalKeyPaginaConcluirCadastro,
                  child: Column(
                    children: [
                      PaginaConcluirCampoNome(
                        controladorConcluirCadastro: controladorConcluirCadastro,
                        controladorPegarUsuario: controladorPegarUsuario,
                      ),
                      const SizedBox(height: 16),
                      PaginaRegistrarCampoGenero(controladorConcluirCadastro: controladorConcluirCadastro),
                      const SizedBox(height: 16),
                      PaginaConcluirCampoNascimento(controladorConcluirCadastro: controladorConcluirCadastro),
                      const SizedBox(height: 16),
                      PaginaConcluirCampoFoto(controladorConcluirCadastro: controladorConcluirCadastro),
                      const SizedBox(height: 16),
                      PaginaConcluirBotaoConcluir(controladorConcluirCadastro: controladorConcluirCadastro),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Visibility(
                      visible: controladorConcluirCadastro.carregando,
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
