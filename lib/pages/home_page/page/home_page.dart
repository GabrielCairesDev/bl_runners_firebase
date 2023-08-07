import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    controlador.loginAutomatico(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text(
              'Carregando preferências...',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
