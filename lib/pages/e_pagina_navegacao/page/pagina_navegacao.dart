import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../k_pagina_inicio/page/pagina_inicio.dart';
import '../../f_pagina_perfil/pages/pagina_perfil.dart';
import '../../m_pagina_ranking_feminino/page/pagina_ranking_feminino.dart';
import '../../l_pagina_ranking_geral/pages/pagina_ranking_geral.dart';
import '../../n_pagina_ranking_masculino/pages/pagina_ranking_masculino.dart';
import '../components/pagina_navegacao_avatar.dart';

class PaginaNavegacao extends StatefulWidget {
  const PaginaNavegacao({super.key});

  @override
  State<PaginaNavegacao> createState() => _PaginaNavegacaoState();
}

class _PaginaNavegacaoState extends State<PaginaNavegacao> {
  final _controladorJump = PageController();
  int _indiceMenu = 0;

  @override
  void initState() {
    super.initState();
    final controlador = context.read<PegarUsuarioAtual>();
    controlador.pegarUsuarioAtual();
  }

  @override
  Widget build(BuildContext context) {
    final controlador = Provider.of<PegarUsuarioAtual>(context);

    return Scaffold(
      body: PageView(
        onPageChanged: (int index) {
          setState(() => _indiceMenu = index);
        },
        controller: _controladorJump,
        children: const [
          PaginaInicio(),
          PaginaRankingGeral(),
          PaginaRankingFeminino(),
          PaginaRankingMasculino(),
          PaginaPerfil(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 55,
        width: double.infinity,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Ínicio'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.groups), label: 'Geral'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.female), label: 'Feminino'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.male), label: 'Masculino'),
            BottomNavigationBarItem(
              icon: PaginaNavegacaoAvatar(controlador: controlador),
              label: 'Perfil',
            ),
          ],
          currentIndex: _indiceMenu,
          selectedItemColor: const Color(0xFFc1d22b),
          unselectedItemColor: const Color(0xFF2e355a),
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(color: Color(0xFFc1d22b)),
          onTap: (int index) {
            setState(() {
              _indiceMenu = index;
              _controladorJump.jumpToPage(index);
            });
          },
          iconSize: 20,
        ),
      ),
    );
  }
}
