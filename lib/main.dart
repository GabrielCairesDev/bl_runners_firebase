import 'package:bl_runners_firebase/firebase_options.dart';
import 'package:bl_runners_firebase/myapp.dart';
import 'package:bl_runners_firebase/providers/_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// LOGS
var logger = Logger(printer: PrettyPrinter());
var loggerNoStack = Logger(printer: PrettyPrinter(methodCount: 0));

void main() async {
  // INICIAR FIREBASE
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // INICIAR APP + PROVIDER
  runApp(MultiProvider(providers: AppProvider.provider, child: const MyApp()));
}
