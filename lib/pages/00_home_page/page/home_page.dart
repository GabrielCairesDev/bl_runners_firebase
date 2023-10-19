import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/pages/00_home_page/controller/home_page_controller.dart';
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
    super.initState();
    _entrarAutomaticamente(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _entrarAutomaticamente(BuildContext context) async {
    final controlador = context.read<HomePageControlador>();
    await controlador
        .entrarAutomaticamente()
        .then((value) => _entrarAutomaticamenteSucesso(value: value))
        .catchError((onError) => _entrarAutomaticamenteErro(onError: onError));
  }

  _entrarAutomaticamenteSucesso({required value}) {
    context.pushReplacement(Rotas.navegar);
    logger.d(value);
  }

  _entrarAutomaticamenteErro({required onError}) {
    context.pushReplacement(Rotas.entrar);
    logger.e(onError);
  }
}
