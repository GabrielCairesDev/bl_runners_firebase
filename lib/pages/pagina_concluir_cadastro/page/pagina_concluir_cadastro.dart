import 'package:bl_runners_firebase/pages/pagina_concluir_cadastro/components/pagina_concluir_botao_sair.dart';
import 'package:flutter/material.dart';

class PaginaConcluirCadastro extends StatelessWidget {
  const PaginaConcluirCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Concluir Cadastro'),
        actions: const [PaginaConcluirBotaoSair()],
      ),
    );
  }
}
