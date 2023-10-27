import 'package:bl_runners_firebase/pages/j_pagina_registrar_atividade/page/pagina_registrar_atividade.dart';
import 'package:bl_runners_firebase/pages/g_pagina_concluir_cadastro/page/pagina_concluir_cadastro.dart';
import 'package:bl_runners_firebase/pages/h_pagina_editar_perfil/page/pagina_editar_perfil.dart';
import 'package:bl_runners_firebase/pages/d_pagina_entrar/page/pagina_entrar.dart';
import 'package:bl_runners_firebase/pages/e_pagina_navegacao/page/pagina_navegacao.dart';
import 'package:bl_runners_firebase/pages/c_pagina_recuperar_conta/page/pagina_recuperar_conta.dart';
import 'package:bl_runners_firebase/pages/i_pagina_admin/page/pagina_admin.dart';
import 'package:go_router/go_router.dart';

import '../pages/a_home_page/page/home_page.dart';
import '../pages/b_pagina_registrar_usuario/page/pagina_registrar.dart';

class Rotas {
  static String home = '/',
      registrarUsuario = '/registrar',
      entrar = '/entrar',
      navegar = '/navegar',
      concluirCadastro = '/concluir',
      editarPerfil = '/editar',
      registrarAtividade = '/adicionar',
      recuperarConta = '/recuperar',
      adm = '/adm';

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
          GoRoute(path: 'adm', builder: (context, state) => const PaginaAdmin()),
        ],
      ),
    ],
  );
}
