import 'package:bl_runners_app/pages/a_home_page/controller/home_page_controller.dart';
import 'package:bl_runners_app/pages/b_pagina_registrar_usuario/controller/pagina_registrar_controlador.dart';
import 'package:bl_runners_app/pages/f_pagina_perfil/controller/pagina_perfil_controlador.dart';
import 'package:bl_runners_app/pages/h_pagina_editar_perfil/controller/pagina_editar_perfil_controlador.dart';
import 'package:bl_runners_app/pages/g_pagina_concluir_cadastro/controller/pagina_concluir_cadastro_controlador.dart';
import 'package:bl_runners_app/pages/d_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_app/pages/e_pagina_navegacao/controller/pagina_navegacao_controlador.dart';
import 'package:bl_runners_app/pages/j_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_app/pages/k_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_app/pages/c_pagina_recuperar_conta/controller/pagina_recuperar_conta_controlador.dart';
import 'package:bl_runners_app/pages/l_pagina_ranking_geral/controller/pagina_ranking_geral_controlador.dart';
import 'package:bl_runners_app/pages/m_pagina_ranking_feminino/controller/pagina_ranking_feminino_controlador.dart';
import 'package:bl_runners_app/pages/n_pagina_ranking_masculino/controller/pagina_ranking_masculino_controlador.dart';
import 'package:bl_runners_app/pages/i_pagina_admin/controller/pagina_admin_controlador.dart';
import 'package:bl_runners_app/providers/firebase/firebase_concluir_cadastro.dart';
import 'package:bl_runners_app/providers/firebase/firebase_editar_perfil.dart';
import 'package:bl_runners_app/providers/firebase/firebase_editar_tag_admin.dart';
import 'package:bl_runners_app/providers/firebase/firebase_editar_tag_autorizado.dart';
import 'package:bl_runners_app/providers/firebase/firebase_editar_tag_master.dart';
import 'package:bl_runners_app/providers/firebase/firebase_entrar.dart';
import 'package:bl_runners_app/providers/firebase/firebase_entrar_automaticamente.dart';
import 'package:bl_runners_app/providers/firebase/firebase_excluir_atividade.dart';
import 'package:bl_runners_app/providers/firebase/firebase_excluir_conta.dart';
import 'package:bl_runners_app/providers/firebase/firebase_pegar_atividades_id.dart';
import 'package:bl_runners_app/providers/firebase/firebase_pegar_atividades_mes_ano.dart';
import 'package:bl_runners_app/providers/firebase/firebase_pegar_todos_usuarios.dart';
import 'package:bl_runners_app/providers/firebase/firebase_pegar_usuarios.dart';
import 'package:bl_runners_app/providers/firebase/firebase_recuperar_conta.dart';
import 'package:bl_runners_app/providers/firebase/firebase_registrar_atividade.dart';
import 'package:bl_runners_app/providers/firebase/firebase_registrar_usuario.dart';
import 'package:bl_runners_app/providers/firebase/firebase_firestore_sair.dart';
import 'package:bl_runners_app/providers/interfaces/concluir_cadastro_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/editar_perfil_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/editar_tag_admin_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/editar_tag_autorizado_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/editar_tag_master_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/excluir_atividade_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/excluir_conta_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/pegar_atividades_id_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/pegar_atividades_mes_ano_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/pegar_todos_usuarios_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/pegar_usuarios_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/sair_use_case.dart';
import 'package:bl_runners_app/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_app/providers/interfaces/entrar_automaticamente_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/entrar_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/recuperar_conta_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:bl_runners_app/providers/interfaces/registrar_usuario_use_case.dart';
import 'package:provider/provider.dart';

class AppProvider {
  static final provider = [
    Provider<EntrarAutomaticamenteUseCase>(
        create: (context) => FirebaseEntrarAutomaticamente()),
    Provider<ExcluirAtividadeUseCase>(
        create: (context) => FirebaseExcluirAtividade()),
    Provider<RegistrarAtividadeUseCase>(
        create: (context) => FirebaseRegistrarAtividade()),
    Provider<EntrarUseCase>(create: (context) => FirebaseEntrar()),
    Provider<RecuperarContaUseCase>(
        create: (context) => FirebaseRecuperarConta()),
    Provider<RegistrarUsuarioUseCase>(
        create: (context) => FirebaseRegistrarUsuario()),
    Provider<SairUseCase>(create: (context) => FirebaseSair()),
    Provider<ExcluirContaUseCase>(create: (context) => FirebaseExcluirConta()),
    Provider<EditarPerfilUseCase>(create: (context) => FireBaseEditarPerfil()),
    Provider<ConcluirCadastroUseCase>(
        create: (context) => FireBaseConcluirCadastro()),
    Provider<RecuperarContaUseCase>(
        create: (context) => FirebaseRecuperarConta()),
    Provider<PegarUsuariosUseCase>(
        create: (context) => FirebasePegarUsuarios()),
    Provider<PegarAtividadesMesAnoUseCase>(
        create: (context) => FirebasePegarAtividadesMesAno()),
    Provider<PegarAtividadesIdUsuarioUseCase>(
        create: (context) => FirebasePegarAtividadesID()),
    Provider<PegarTodosUsuariosUseCase>(
        create: (context) => FirebasePegarTodosUsuario()),
    Provider<EditarTagMasterUseCase>(
        create: (context) => FireBaseEditarTagMaster()),
    Provider<EditarTagAdminUseCase>(
        create: (context) => FireBaseEditarTagAdmin()),
    Provider<EditarTagAutorizadoUseCase>(
        create: (context) => FireBaseEditarTagAutorizado()),
    ChangeNotifierProvider<HomePageControlador>(
      create: (context) => HomePageControlador(
        entrarAutomaticamenteUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaRegistrarAtividadeControlador>(
      create: (context) => PaginaRegistrarAtividadeControlador(
        registrarAtividadeUserCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaEntrarControlador>(
      create: (context) => PaginaEntrarControlador(
        entrarUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaRegistrarUsuarioControlador>(
      create: (context) => PaginaRegistrarUsuarioControlador(
        registrarUsuarioUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaPerfilControlador>(
      create: (context) => PaginaPerfilControlador(
        excluirAtividadeUseCase: context.read(),
        sairUseCase: context.read(),
        pegarAtividadesIdUsuarioUseCase: context.read(),
        pegarUsuariosUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaEditarPerfilControlador>(
      create: (context) => PaginaEditarPerfilControlador(
        excluirContaUseCase: context.read(),
        editarPerfilUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaConcluirCadastroControlador>(
      create: (context) => PaginaConcluirCadastroControlador(
        concluirCadastroUseCase: context.read(),
        excluirContaUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaRecuperarContaControlador>(
      create: (context) => PaginaRecuperarContaControlador(
        recuperarContaUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaInicioControlador>(
      create: (context) => PaginaInicioControlador(
        pegarAtividadesUseCase: context.read(),
        pegarUsuariosUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaRankingGeralControlador>(
      create: (context) => PaginaRankingGeralControlador(
        pegarAtividadesUseCase: context.read(),
        pegarUsuariosUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaRankingFemininoControlador>(
      create: (context) => PaginaRankingFemininoControlador(
        pegarAtividadesUseCase: context.read(),
        pegarUsuariosUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaRankingMasculinoControlador>(
      create: (context) => PaginaRankingMasculinoControlador(
        pegarAtividadesUseCase: context.read(),
        pegarUsuariosUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PaginaAdminControlador>(
      create: (context) => PaginaAdminControlador(
        editarTagAdminUseCase: context.read(),
        editarTagMasterUseCase: context.read(),
        pegarTodosUsuariosUseCase: context.read(),
        editarTagAutorizadoUseCase: context.read(),
      ),
    ),
    ChangeNotifierProvider<PegarUsuarioAtual>(
      create: (context) => PegarUsuarioAtual(),
    ),
    ChangeNotifierProvider<PaginaNavegacaoControlador>(
      create: (context) => PaginaNavegacaoControlador(),
    ),
  ];
}
