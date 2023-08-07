import 'package:bl_runners_firebase/pages/home_page/controller/home_page_controller.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/pagina_registrar/controller/pagina_registrar_controlador.dart';
import 'package:provider/provider.dart';

import '../pages/pagina_concluir_registro/controller/pagina_concluir_registro_controlador.dart';

class AppProvider {
  static final provider = [
    ChangeNotifierProvider<HomePageController>(create: (context) => HomePageController()),
    ChangeNotifierProvider<PaginaRegistrarControlador>(create: (context) => PaginaRegistrarControlador()),
    ChangeNotifierProvider<PaginaEntrarControlador>(create: (context) => PaginaEntrarControlador()),
    ChangeNotifierProvider<PaginaConcluirRegistroControlador>(create: (context) => PaginaConcluirRegistroControlador()),
  ];
}
