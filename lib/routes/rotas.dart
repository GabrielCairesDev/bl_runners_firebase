import 'package:bl_runners_firebase/pages/pagina_entrar/page/pagina_entrar.dart';
import 'package:go_router/go_router.dart';

import '../pages/pagina_registrar/page/pagina_registrar.dart';

class Rotas {
  static String home = '/', registrar = '/registrar', entrar = '/entrar';

  static final GoRouter rotas = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        // builder: (context, state) => const HomePage(),
        builder: (context, state) => const PaginaEntrar(),
        routes: <GoRoute>[
          GoRoute(
            path: 'registrar',
            builder: (context, state) => const PaginaRegistrar(),
          ),
          GoRoute(
            path: 'entrar',
            builder: (context, state) => const PaginaEntrar(),
          ),
        ],
      ),
    ],
  );
}
