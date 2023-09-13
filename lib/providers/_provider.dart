import 'package:bl_runners_firebase/pages/00_home_page/controller/home_page_controller.dart';
import 'package:bl_runners_firebase/pages/06_pagina_concluir_cadastro/controller/pagina_concluir_controlador.dart';
import 'package:bl_runners_firebase/pages/02_pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/03_pagina_navegacao/controller/pagina_navegacao_controlador.dart';
import 'package:bl_runners_firebase/pages/01_pagina_registrar_usuario/controller/pagina_registrar_controlador.dart';
import 'package:bl_runners_firebase/pages/07_pagina_registrar_atividade/controller/pagina_registrar_atividade_controlador.dart';
import 'package:bl_runners_firebase/pages/pagina_inicio/controller/pagina_inicio_controlador.dart';
import 'package:bl_runners_firebase/providers/auth_provider.dart';
import 'package:bl_runners_firebase/providers/data_provider.dart';
import 'package:provider/provider.dart';

import '../pages/05_pagina_editar_perfil/controller/pagina_editar_perfil_controlador.dart';

class AppProvider {
  static final provider = [
    // HOME PAGE
    ChangeNotifierProvider<HomePageController>(create: (context) => HomePageController()),
    // FIREBASE
    ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
    ChangeNotifierProvider<DataProvider>(create: (context) => DataProvider()),
    // PAGINAS
    ChangeNotifierProvider<PaginaRegistrarControlador>(create: (context) => PaginaRegistrarControlador()),
    ChangeNotifierProvider<PaginaEntrarControlador>(create: (context) => PaginaEntrarControlador()),
    ChangeNotifierProvider<PaginaConcluirControlador>(create: (context) => PaginaConcluirControlador()),
    ChangeNotifierProvider<PaginaNavegacaoControlador>(create: (context) => PaginaNavegacaoControlador()),
    ChangeNotifierProvider<PaginaEditarPerfilControlador>(create: (context) => PaginaEditarPerfilControlador()),
    ChangeNotifierProvider<PaginaRegistrarAtividadeControlador>(create: (context) => PaginaRegistrarAtividadeControlador()),
    ChangeNotifierProvider<PaginaInicioControlador>(create: (context) => PaginaInicioControlador()),
  ];
}
