import 'package:bl_runners_firebase/pages/00_home_page/controller/home_page_controller.dart';
import 'package:bl_runners_firebase/pages/06_pagina_concluir_cadastro/controller/pagina_concluir_controlador.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/03_pagina_navegacao/controller/pagina_navegacao_controlador.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/pages/08_pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_firebase/providers/auth_provider.dart';
import 'package:bl_runners_firebase/providers/data_provider.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_concluir_cadastro.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_editar_perfil.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_entrar.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_entrar_automaticamente.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_recuperar_conta.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_registrar_atividade.dart';
import 'package:bl_runners_firebase/providers/firebase/firestore/firebase_firestore_registrar_usuario.dart';
import 'package:bl_runners_firebase/providers/firebase/storage/firebase_storage_salvar_editar_foto_perfil.dart';
import 'package:bl_runners_firebase/providers/firebase/storage/firebase_storage_salvar_foto_perfil.dart';
import 'package:bl_runners_firebase/providers/interfaces/entrar_automaticamente_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/entrar_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/recuperar_conta_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_atividade_use_case.dart';
import 'package:bl_runners_firebase/providers/interfaces/registrar_usuario_use_case.dart';
import 'package:provider/provider.dart';

import '../pages/05_pagina_editar_perfil/controller/pagina_editar_perfil_controlador.dart';

class AppProvider {
  static final provider = [
    Provider<EntrarAutomaticamenteUseCase>(create: (context) => FirebaseFirestoreEntrarAutomaticamente()),
    Provider<RegistrarAtividadeUseCase>(create: (context) => FirebaseFirestoreRegistrarAtividade()),
    Provider<RegistrarUsuarioUseCase>(create: (context) => FirebaseFirestoreRegistrarUsuario()),
    Provider<EntrarUseCase>(create: (context) => FirebaseFirestoreEntrar()),
    Provider<RecuperarContaUseCase>(create: (context) => FirebaseFirestoreRecuperarConta()),
    //
    ChangeNotifierProvider<PaginaEntrarControlador>(
        create: (context) => PaginaEntrarControlador(entrarUseCase: Provider.of(context, listen: false), recuperarUseCase: context.read())),
    ChangeNotifierProvider<PaginaRegistrarAtividadeControlador>(
        create: (context) => PaginaRegistrarAtividadeControlador(registrarAtividadeUserCase: context.read())),
    ChangeNotifierProvider<HomePageController>(create: (context) => HomePageController(entrarAutomaticamenteUseCase: context.read())),
    //
    ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
    ChangeNotifierProvider<DataProvider>(create: (context) => DataProvider()),
    ChangeNotifierProvider<FireBaseFireStoreConcluirCadastro>(create: (context) => FireBaseFireStoreConcluirCadastro()),
    ChangeNotifierProvider<FireBaseFireStoreEditarPerfil>(create: (context) => FireBaseFireStoreEditarPerfil()),
    ChangeNotifierProvider<FirebaseStorageSalvarFotoPerfil>(create: (context) => FirebaseStorageSalvarFotoPerfil()),
    ChangeNotifierProvider<FirebaseStorageEditarFotoPerfil>(create: (context) => FirebaseStorageEditarFotoPerfil()),
    ChangeNotifierProvider<PaginaConcluirControlador>(create: (context) => PaginaConcluirControlador()),
    ChangeNotifierProvider<PaginaNavegacaoControlador>(create: (context) => PaginaNavegacaoControlador()),
    ChangeNotifierProvider<PaginaEditarPerfilControlador>(create: (context) => PaginaEditarPerfilControlador()),
    ChangeNotifierProvider<PaginaInicioControlador>(create: (context) => PaginaInicioControlador()),
  ];
}
