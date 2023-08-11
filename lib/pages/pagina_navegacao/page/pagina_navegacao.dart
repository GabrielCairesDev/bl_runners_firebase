import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider_usuario.dart';
import '../../pagina_inicio/page/pagina_inicio.dart';
import '../../pagina_perfil/pages/pagina_perfil.dart';
import '../../pagina_ranking_femenino/page/pagina_ranking_feminino.dart';
import '../../pagina_ranking_geral/pages/Pagina_ranking_geral.dart';
import '../../pagina_ranking_masculino/pages/pagina_ranking_masculino.dart';

class PaginaNavegacao extends StatefulWidget {
  const PaginaNavegacao({super.key});

  @override
  State<PaginaNavegacao> createState() => _PaginaNavegacaoState();
}

class _PaginaNavegacaoState extends State<PaginaNavegacao> {
  final controladorPagina = PageController();
  int indiceMenu = 0;

  @override
  Widget build(BuildContext context) {
    // final controlador = Provider.of<PaginaNavegacaoControlador>(context);
    final controladorUsuarioProvider = Provider.of<ProviderUsuario>(context);

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
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ínicio'),
            const BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Geral'),
            const BottomNavigationBarItem(icon: Icon(Icons.female), label: 'Feminino'),
            const BottomNavigationBarItem(icon: Icon(Icons.male), label: 'Masculino'),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 24,
                height: 24,
                child: ClipOval(
                  child: Image.network(
                    controladorUsuarioProvider.usuario!.fotoUrl.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
