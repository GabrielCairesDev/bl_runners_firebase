import 'package:bl_runners_firebase/pages/home_page/controller/home_page_controller.dart';
import 'package:bl_runners_firebase/pages/pagina_concluir_cadastro/controller/pagina_concluir_controlador.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/pagina_navegacao/controller/pagina_navegacao_controlador.dart';
import 'package:bl_runners_firebase/pages/pagina_registrar/controller/pagina_registrar_controlador.dart';
import 'package:bl_runners_firebase/providers/provider_usuario.dart';
import 'package:provider/provider.dart';

class AppProvider {
  static final provider = [
    ChangeNotifierProvider<HomePageController>(create: (context) => HomePageController()),
    ChangeNotifierProvider<PaginaRegistrarControlador>(create: (context) => PaginaRegistrarControlador()),
    ChangeNotifierProvider<PaginaEntrarControlador>(create: (context) => PaginaEntrarControlador()),
    ChangeNotifierProvider<PaginaConcluirControlador>(create: (context) => PaginaConcluirControlador()),
    ChangeNotifierProvider<PaginaNavegacaoControlador>(create: (context) => PaginaNavegacaoControlador()),
    ChangeNotifierProvider<ProviderUsuario>(create: (context) => ProviderUsuario()),
  ];
}
