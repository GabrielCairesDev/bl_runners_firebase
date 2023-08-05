import 'package:bl_runners_firebase/pages/pagin_registrar/controller/pagina_registrar_controlador.dart';
import 'package:provider/provider.dart';

class AppProvider {
  static final provider = [
    ChangeNotifierProvider<PaginaRegistrarControlador>(
        create: (context) => PaginaRegistrarControlador()),
  ];
}
