import 'package:go_router/go_router.dart';

import '../pages/pagin_registrar/pagina_registrar.dart';

class Rotas {
  static String home = '/';
  static String registrar = '/registrar';

  static final GoRouter rotas = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        // builder: (context, state) => const HomePage(),
        builder: (context, state) => const PaginaRegistrar(),
        routes: <GoRoute>[
          GoRoute(
            path: 'registrar',
            builder: (context, state) => const PaginaRegistrar(),
          ),
        ],
      ),
    ],
  );
}
