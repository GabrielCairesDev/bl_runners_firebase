import 'package:bl_runners_firebase/pages/00_home_page/controller/home_page_controller.dart';
import 'package:bl_runners_firebase/providers/data_provider.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    entradaAutomatica(context);
    final controladorDataProvider = Provider.of<DataProvider>(context, listen: false);
    controladorDataProvider.pegarUsuarioData();
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

entradaAutomatica(BuildContext context) {
  final controladorHomePage = context.read<HomePageController>();
  controladorHomePage.entrarAutomaticamente().then((value) {
    context.pushReplacement(Rotas.navegar);
    debugPrint(value);
  }).catchError((onError) {
    context.pushReplacement(Rotas.entrar);
    debugPrint(onError);
  });
}
