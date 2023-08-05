import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:flutter/material.dart';

import 'myapp_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Rotas.rotas,
      debugShowCheckedModeBanner: false,
      theme: myAppTheme(),
    );
  }
}
