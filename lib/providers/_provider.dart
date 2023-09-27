import 'package:bl_runners_firebase/pages/00_home_page/controller/home_page_controller.dart';
import 'package:bl_runners_firebase/pages/06_pagina_concluir_cadastro/controller/pagina_concluir_controlador.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/03_pagina_navegacao/controller/pagina_navegacao_controlador.dart';
import 'package:bl_runners_firebase/pages/01_pagina_registrar_usuario/controller/pagina_registrar_controlador.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_firebase/providers/auth_provider.dart';
import 'package:bl_runners_firebase/providers/data_provider.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_concluir_cadastro.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_editar_perfil.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_entrar.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_recuperar_conta.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_registrar_atividade.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_registrar_usuario.dart';
import 'package:bl_runners_firebase/providers/firebase/storage/firebase_storage_salvar_editar_foto_perfil.dart';
import 'package:bl_runners_firebase/providers/firebase/storage/firebase_storage_salvar_foto_perfil.dart';
import 'package:bl_runners_firebase/providers/interfaces/entrar_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/recuperar_conta_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_usuario_use_case.dart';
import 'package:provider/provider.dart';

import '../pages/05_pagina_editar_perfil/controller/pagina_editar_perfil_controlador.dart';

class AppProvider {
  static final provider = [
    // Home Page
    ChangeNotifierProvider<HomePageController>(create: (context) => HomePageController()),
    // FIREBASE
    ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
    ChangeNotifierProvider<DataProvider>(create: (context) => DataProvider()),
    // FireBase FireStore
    ChangeNotifierProvider<FireBaseFireStoreConcluirCadastro>(create: (context) => FireBaseFireStoreConcluirCadastro()),
    ChangeNotifierProvider<FireBaseFireStoreEditarPerfil>(create: (context) => FireBaseFireStoreEditarPerfil()),
    // Use Cases
    Provider<RegistrarAtividadeUseCase>(create: (context) => FirebaseFirestoreRegistrarAtividade()),
    Provider<RegistrarUsuarioUseCase>(create: (context) => FirebaseFirestoreRegistrarUsuario()),
    Provider<EntrarUseCase>(create: (context) => FirebaseFirestoreEntrar()),
    Provider<RecuperarContaUseCase>(create: (context) => FirebaseFirestoreRecuperarConta()),

    // FireBase Storage
    ChangeNotifierProvider<FirebaseStorageSalvarFotoPerfil>(create: (context) => FirebaseStorageSalvarFotoPerfil()),
    ChangeNotifierProvider<FirebaseStorageEditarFotoPerfil>(create: (context) => FirebaseStorageEditarFotoPerfil()),
    // Paginas
    ChangeNotifierProvider<PaginaRegistrarUsuarioControlador>(
        create: (context) => PaginaRegistrarUsuarioControlador(registrarUsuarioUseCase: Provider.of(context, listen: false))),
    ChangeNotifierProvider<PaginaEntrarControlador>(
        create: (context) => PaginaEntrarControlador(
            entrarUseCase: Provider.of(context, listen: false), recuperarUseCase: Provider.of(context, listen: false))),
    ChangeNotifierProvider<PaginaConcluirControlador>(create: (context) => PaginaConcluirControlador()),
    ChangeNotifierProvider<PaginaNavegacaoControlador>(create: (context) => PaginaNavegacaoControlador()),
    ChangeNotifierProvider<PaginaEditarPerfilControlador>(create: (context) => PaginaEditarPerfilControlador()),
    ChangeNotifierProvider<PaginaRegistrarAtividadeControlador>(
        create: (context) => PaginaRegistrarAtividadeControlador(registrarAtividadeUserCase: Provider.of(context, listen: false))),
    ChangeNotifierProvider<PaginaInicioControlador>(create: (context) => PaginaInicioControlador()),
  ];
}
