import 'package:bl_runners_firebase/pages/pagina_registrar_atividade/page/pagina_registrar_atividade.dart';
import 'package:bl_runners_firebase/pages/pagina_concluir_cadastro/page/pagina_concluir_cadastro.dart';
import 'package:bl_runners_firebase/pages/pagina_editar_perfil/page/pagina_editar_perfil.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/page/pagina_entrar.dart';
import 'package:bl_runners_firebase/pages/pagina_navegacao/page/pagina_navegacao.dart';
import 'package:go_router/go_router.dart';

import '../pages/home_page/page/home_page.dart';
import '../pages/pagina_registrar_usuario/page/pagina_registrar.dart';

class Rotas {
  static String home = '/',
      registrar = '/registrar',
      entrar = '/entrar',
      navegar = '/navegar',
      concluir = '/concluir',
      editar = '/editar',
      adicionar = '/adicionar';

  static final GoRouter rotas = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: <GoRoute>[
          GoRoute(path: 'registrar', builder: (context, state) => const PaginaRegistrar()),
          GoRoute(path: 'entrar', builder: (context, state) => const PaginaEntrar()),
          GoRoute(path: 'navegar', builder: (context, state) => const PaginaNavegacao()),
          GoRoute(path: 'concluir', builder: (context, state) => const PaginaConcluirCadastro()),
          GoRoute(path: 'editar', builder: (context, state) => const PaginaEditarPerfil()),
          GoRoute(path: 'adicionar', builder: (context, state) => const PaginaRegistrarAtividade()),
        ],
      ),
    ],
  );
}
