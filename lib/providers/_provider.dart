import 'package:bl_runners_firebase/pages/00_home_page/controller/home_page_controller.dart';
import 'package:bl_runners_firebase/pages/01_pagina_registrar_usuario/controller/pagina_registrar_controlador.dart';
import 'package:bl_runners_firebase/pages/04_pagina_perfil/controller/pagina_perfil_controlador.dart';
import 'package:bl_runners_firebase/pages/05_pagina_editar_perfil/controller/pagina_editar_perfil_controlador.dart';
import 'package:bl_runners_firebase/pages/06_pagina_concluir_cadastro/controller/pagina_concluir_cadastro_controlador.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/03_pagina_navegacao/controller/pagina_navegacao_controlador.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_excluir_conta.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_sair.dart';
import 'package:bl_runners_firebase/providers/interfaces/concluir_cadastro_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/excluir_conta_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/sair_use_case.dart';
import 'package:bl_runners_firebase/providers/pegar_usuario.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_concluir_cadastro.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_editar_perfil.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_entrar.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_entrar_automaticamente.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_recuperar_conta.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_registrar_atividade.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_registrar_usuario.dart';
import 'package:bl_runners_firebase/providers/firebase/storage/firebase_storage_salvar_editar_foto_perfil.dart';
import 'package:bl_runners_firebase/providers/interfaces/entrar_automaticamente_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/entrar_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/recuperar_conta_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_usuario_use_case.dart';
import 'package:provider/provider.dart';

class AppProvider {
  static final provider = [
    // HOME PAGE
    Provider<EntrarAutomaticamenteUseCase>(create: (context) => FirebaseFirestoreEntrarAutomaticamente()),
    ChangeNotifierProvider<HomePageController>(create: (context) => HomePageController(entrarAutomaticamenteUseCase: context.read())),

    // PAGINA REGISTRAR ATIVIDADE
    Provider<RegistrarAtividadeUseCase>(create: (context) => FirebaseFirestoreRegistrarAtividade()),
    ChangeNotifierProvider<PaginaRegistrarAtividadeControlador>(
        create: (context) => PaginaRegistrarAtividadeControlador(registrarAtividadeUserCase: context.read())),

    // PAGINA ENTRAR
    Provider<EntrarUseCase>(create: (context) => FirebaseFirestoreEntrar()),
    Provider<RecuperarContaUseCase>(create: (context) => FirebaseFirestoreRecuperarConta()),
    ChangeNotifierProvider<PaginaEntrarControlador>(
        create: (context) => PaginaEntrarControlador(entrarUseCase: context.read(), recuperarContaUseCase: context.read())),

    // PAGINA REGISTRAR USUARIO
    Provider<RegistrarUsuarioUseCase>(create: (context) => FirebaseFirestoreRegistrarUsuario()),
    ChangeNotifierProvider<PaginaRegistrarUsuarioControlador>(
        create: (context) => PaginaRegistrarUsuarioControlador(registrarUsuarioUseCase: context.read())),

    // PAGINA PERFIL
    Provider<SairUseCase>(create: (context) => FirebaseStoreSair()),
    ChangeNotifierProvider<PaginaPerfilControlador>(create: (context) => PaginaPerfilControlador(sairUseCase: context.read())),

    // PAGINA EDITAR PERFIL
    Provider<ExcluirContaUseCase>(create: (context) => FirebaseFirestoreExcluirConta()),
    ChangeNotifierProvider<PaginaEditarPerfilControlador>(
        create: (context) => PaginaEditarPerfilControlador(excluirContaUseCase: context.read())),

    //
    Provider<ConcluirCadastroUseCase>(create: (context) => FireBaseFireStoreConcluirCadastro()),
    ChangeNotifierProvider<PaginaConcluirCadastroControlador>(
        create: (context) => PaginaConcluirCadastroControlador(concluirCadastroUseCase: context.read())),

    // PAGINA INICIO
    ChangeNotifierProvider<PaginaInicioControlador>(create: (context) => PaginaInicioControlador()),

    //
    ChangeNotifierProvider<PegarUsuario>(create: (context) => PegarUsuario()),
    ChangeNotifierProvider<FireBaseFireStoreEditarPerfil>(create: (context) => FireBaseFireStoreEditarPerfil()),
    ChangeNotifierProvider<FirebaseStorageEditarFotoPerfil>(create: (context) => FirebaseStorageEditarFotoPerfil()),
    ChangeNotifierProvider<PaginaNavegacaoControlador>(create: (context) => PaginaNavegacaoControlador()),
  ];
}
