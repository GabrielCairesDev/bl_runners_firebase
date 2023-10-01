import 'package:bl_runners_firebase/pages/00_home_page/controller/home_page_controller.dart';
import 'package:bl_runners_firebase/pages/01_pagina_registrar_usuario/controller/pagina_registrar_controlador.dart';
import 'package:bl_runners_firebase/pages/04_pagina_perfil/controller/pagina_perfil_controlador.dart';
import 'package:bl_runners_firebase/pages/05_pagina_editar_perfil/controller/pagina_editar_perfil_controlador.dart';
import 'package:bl_runners_firebase/pages/06_pagina_concluir_cadastro/controller/pagina_concluir_cadastro_controlador.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/03_pagina_navegacao/controller/pagina_navegacao_controlador.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_concluir_cadastro.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_editar_perfil.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_entrar.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_entrar_automaticamente.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_excluir_conta.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_recuperar_conta.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_registrar_atividade.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_registrar_usuario.dart';
import 'package:bl_runners_firebase/providers/firebase/firebase_firestore_sair.dart';
import 'package:bl_runners_firebase/providers/interfaces/concluir_cadastro_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/editar_perfil_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/excluir_conta_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/sair_use_case.dart';
import 'package:bl_runners_firebase/providers/firebase/real_time/pegar_usuario.dart';
import 'package:bl_runners_firebase/providers/interfaces/entrar_automaticamente_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/entrar_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/recuperar_conta_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_usuario_use_case.dart';
import 'package:provider/provider.dart';

class AppProvider {
  static final provider = [
    // HOME PAGE
    Provider<EntrarAutomaticamenteUseCase>(create: (context) => FirebaseEntrarAutomaticamente()),
    ChangeNotifierProvider<HomePageControlador>(create: (context) => HomePageControlador(entrarAutomaticamenteUseCase: context.read())),

    // PAGINA REGISTRAR ATIVIDADE
    Provider<RegistrarAtividadeUseCase>(create: (context) => FirebaseRegistrarAtividade()),
    ChangeNotifierProvider<PaginaRegistrarAtividadeControlador>(
        create: (context) => PaginaRegistrarAtividadeControlador(registrarAtividadeUserCase: context.read())),

    // PAGINA ENTRAR
    Provider<EntrarUseCase>(create: (context) => FirebaseEntrar()),
    Provider<RecuperarContaUseCase>(create: (context) => FirebaseRecuperarConta()),
    ChangeNotifierProvider<PaginaEntrarControlador>(
        create: (context) => PaginaEntrarControlador(entrarUseCase: context.read(), recuperarContaUseCase: context.read())),

    // PAGINA REGISTRAR USUARIO
    Provider<RegistrarUsuarioUseCase>(create: (context) => FirebaseRegistrarUsuario()),
    ChangeNotifierProvider<PaginaRegistrarUsuarioControlador>(
        create: (context) => PaginaRegistrarUsuarioControlador(registrarUsuarioUseCase: context.read())),

    // PAGINA PERFIL
    Provider<SairUseCase>(create: (context) => FirebaseSair()),
    ChangeNotifierProvider<PaginaPerfilControlador>(create: (context) => PaginaPerfilControlador(sairUseCase: context.read())),

    // PAGINA EDITAR PERFIL
    Provider<ExcluirContaUseCase>(create: (context) => FirebaseExcluirConta()),
    Provider<EditarPerfil>(create: (context) => FireBaseEditarPerfil()),
    ChangeNotifierProvider<PaginaEditarPerfilControlador>(
        create: (context) => PaginaEditarPerfilControlador(excluirContaUseCase: context.read(), editarPerfilUseCase: context.read())),

    // PAGINA CONCLUIR CADASTRO
    Provider<ConcluirCadastroUseCase>(create: (context) => FireBaseConcluirCadastro()),
    ChangeNotifierProvider<PaginaConcluirCadastroControlador>(
        create: (context) => PaginaConcluirCadastroControlador(concluirCadastroUseCase: context.read())),

    // PAGINA INICIO
    ChangeNotifierProvider<PaginaInicioControlador>(create: (context) => PaginaInicioControlador()),

    //
    ChangeNotifierProvider<PegarUsuario>(create: (context) => PegarUsuario()),
    ChangeNotifierProvider<PaginaNavegacaoControlador>(create: (context) => PaginaNavegacaoControlador()),
  ];
}
