import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/theme/theme.dart';
import 'package:flutter/material.dart';

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
