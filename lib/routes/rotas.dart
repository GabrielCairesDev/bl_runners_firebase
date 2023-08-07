import 'package:bl_runners_firebase/pages/pagina_entrar/page/pagina_entrar.dart';
import 'package:bl_runners_firebase/pages/pagina_navegacao/page/pagina_navegacao.dart';
import 'package:go_router/go_router.dart';

import '../pages/home_page/page/home_page.dart';
import '../pages/pagina_registrar/page/pagina_registrar.dart';

class Rotas {
  static String home = '/', registrar = '/registrar', entrar = '/entrar', navegar = '/navegar';

  static final GoRouter rotas = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: <GoRoute>[
          GoRoute(
            path: 'registrar',
            builder: (context, state) => const PaginaRegistrar(),
          ),
          GoRoute(
            path: 'entrar',
            builder: (context, state) => const PaginaEntrar(),
          ),
          GoRoute(
            path: 'navegar',
            builder: (context, state) => const PaginaNavegacao(),
          ),
        ],
      ),
    ],
  );
}
