import 'package:bl_runners_firebase/firebase_options.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp.router(
      routerConfig: Rotas.rotas, debugShowCheckedModeBanner: false));
}
