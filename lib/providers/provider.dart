import 'package:bl_runners_firebase/pages/00_home_page/controller/home_page_controller.dart';
import 'package:bl_runners_firebase/pages/01_pagina_registrar_usuario/controller/pagina_registrar_controlador.dart';
import 'package:bl_runners_firebase/pages/04_pagina_perfil/controller/pagina_perfil_controlador.dart';
import 'package:bl_runners_firebase/pages/05_pagina_editar_perfil/controller/pagina_editar_perfil_controlador.dart';
import 'package:bl_runners_firebase/pages/06_pagina_concluir_cadastro/controller/pagina_concluir_cadastro_controlador.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/03_pagina_navegacao/controller/pagina_navegacao_controlador.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_firebase/pages/09_pagina_recuperar_conta/controller/pagina_recuperar_conta_controlador.dart';
import 'package:bl_runners_firebase/pages/10_pagina_ranking_geral/controller/pagina_ranking_geral_controlador.dart';
import 'package:bl_runners_firebase/pages/11_pagina_ranking_feminino/controller/pagina_ranking_feminino_controlador.dart';
import 'package:bl_runners_firebase/pages/12_pagina_ranking_masculino/controller/pagina_ranking_masculino_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_concluir_cadastro.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_editar_perfil.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_entrar.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_entrar_automaticamente.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_excluir_atividade.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_excluir_conta.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_pegar_atividades_id.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_pegar_atividades_mes_ano.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_pegar_usuarios.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_recuperar_conta.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_registrar_atividade.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_registrar_usuario.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_firestore_sair.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_salvar_foto.dart';
import 'package:bl_runners_firebase/providers/interfaces/concluir_cadastro_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/editar_perfil_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/excluir_atividade_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/excluir_conta_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_id_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_atividades_mes_ano_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/pegar_usuarios_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/sair_use_case.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/providers/interfaces/entrar_automaticamente_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/entrar_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/recuperar_conta_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_usuario_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/salvar_foto_use_case.dart';
import 'package:provider/provider.dart';

class AppProvider {
  static final provider = [
    Provider<EntrarAutomaticamenteUseCase>(create: (context) => FirebaseEntrarAutomaticamente()),
    Provider<RegistrarAtividadeUseCase>(create: (context) => FirebaseRegistrarAtividade()),
    Provider<EntrarUseCase>(create: (context) => FirebaseEntrar()),
    Provider<RecuperarContaUseCase>(create: (context) => FirebaseRecuperarConta()),
    Provider<RegistrarUsuarioUseCase>(create: (context) => FirebaseRegistrarUsuario()),
    Provider<SairUseCase>(create: (context) => FirebaseSair()),
    Provider<ExcluirContaUseCase>(create: (context) => FirebaseExcluirConta()),
    Provider<EditarPerfil>(create: (context) => FireBaseEditarPerfil()),
    Provider<ConcluirCadastroUseCase>(create: (context) => FireBaseConcluirCadastro()),
    Provider<SalvarFotoUseCase>(create: (context) => FirebaseSalvarFoto()),
    Provider<RecuperarContaUseCase>(create: (context) => FirebaseRecuperarConta()),
    Provider<PegarUsuariosUseCase>(create: (context) => FirebasePegarUsuarios()),
    Provider<PegarAtividadesMesAnoUseCase>(create: (context) => FirebasePegarAtividadesMesAno()),
    Provider<ExcluirAtividadeUseCase>(create: (context) => FirebaseExcluirAtividade()),
    Provider<PegarAtividadesIdUsuarioUseCase>(create: (context) => FirebasePegarAtividadesID()),
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
        salvarFotoUseCase: context.read(),
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
        excluirAtividadeUseCase: context.read(),
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
    ChangeNotifierProvider<PegarUsuarioAtual>(
      create: (context) => PegarUsuarioAtual(),
    ),
    ChangeNotifierProvider<PaginaNavegacaoControlador>(
      create: (context) => PaginaNavegacaoControlador(),
    ),
  ];
}
