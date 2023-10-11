import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../08_pagina_inicio/page/pagina_inicio.dart';
import '../../04_pagina_perfil/pages/pagina_perfil.dart';
import '../../11_pagina_ranking_feminino/page/pagina_ranking_feminino.dart';
import '../../10_pagina_ranking_geral/pages/pagina_ranking_geral.dart';
import '../../12_pagina_ranking_masculino/pages/pagina_ranking_masculino.dart';
import '../components/pagina_navegacao_avatar.dart';

class PaginaNavegacao extends StatefulWidget {
  const PaginaNavegacao({super.key});

  @override
  State<PaginaNavegacao> createState() => _PaginaNavegacaoState();
}

class _PaginaNavegacaoState extends State<PaginaNavegacao> {
  final controladorPagina = PageController();
  int indiceMenu = 0;

  @override
  void initState() {
    super.initState();
    final controladorDataProvider = Provider.of<PegarUsuarioAtual>(context, listen: false);
    controladorDataProvider.pegarUsuarioData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (int index) {
          setState(() => indiceMenu = index);
        },
        controller: controladorPagina,
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ínicio'),
            BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Geral'),
            BottomNavigationBarItem(icon: Icon(Icons.female), label: 'Feminino'),
            BottomNavigationBarItem(icon: Icon(Icons.male), label: 'Masculino'),
            BottomNavigationBarItem(
              icon: PaginaNavegacaoAvatar(),
              label: 'Perfil',
            ),
          ],
          currentIndex: indiceMenu,
          selectedItemColor: const Color(0xFFc1d22b),
          unselectedItemColor: const Color(0xFF2e355a),
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(color: Color(0xFFc1d22b)),
          onTap: (int index) {
            setState(() {
              indiceMenu = index;
              controladorPagina.jumpToPage(index);
            });
          },
          iconSize: 20,
        ),
      ),
    );
  }
}
