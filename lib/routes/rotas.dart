import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/page/pagina_registrar_atividade.dart';
import 'package:bl_runners_firebase/pages/06_pagina_concluir_cadastro/page/pagina_concluir_cadastro.dart';
import 'package:bl_runners_firebase/pages/05_pagina_editar_perfil/page/pagina_editar_perfil.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/page/pagina_entrar.dart';
import 'package:bl_runners_firebase/pages/03_pagina_navegacao/page/pagina_navegacao.dart';
import 'package:bl_runners_firebase/pages/09_pagina_recuperar_conta/page/pagina_recuperar_conta.dart';
import 'package:go_router/go_router.dart';

import '../pages/00_home_page/page/home_page.dart';
import '../pages/01_pagina_registrar_usuario/page/pagina_registrar.dart';

class Rotas {
  static String home = '/',
      registrarUsuario = '/registrar',
      entrar = '/entrar',
      navegar = '/navegar',
      concluirCadastro = '/concluir',
      editarPerfil = '/editar',
      adicionarAtividade = '/adicionar',
      recuperarConta = '/recuperar';

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
          GoRoute(path: 'recuperar', builder: (context, state) => const PaginaRecuperarConta()),
        ],
      ),
    ],
  );
}
