import 'package:bl_runners_firebase/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final authprovider = Provider.of<AuthProvider>(context, listen: false);
    authprovider.autoEntrar(context);
    super.initState();
    // final controlador = context.read<HomePageController>();
    // controlador.loginAutomatico(context);
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
