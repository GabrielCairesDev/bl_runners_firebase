import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider_usuario.dart';
import '../controller/home_page_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final controlador = context.read<HomePageController>();
    final controladorProvider = context.read<ProviderUsuario>();

    controlador.loginAutomatico(context);
    controladorProvider.iniciarModeloDeUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
