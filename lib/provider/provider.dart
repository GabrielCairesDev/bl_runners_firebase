import 'package:bl_runners_firebase/pages/pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/pagina_registrar/controller/pagina_registrar_controlador.dart';
import 'package:provider/provider.dart';

class AppProvider {
  static final provider = [
    ChangeNotifierProvider<PaginaRegistrarControlador>(
        create: (context) => PaginaRegistrarControlador()),
    ChangeNotifierProvider<PaginaEntrarControlador>(
        create: (context) => PaginaEntrarControlador()),
  ];
}
