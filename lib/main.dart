import 'package:bl_runners_app/firebase_options.dart';
import 'package:bl_runners_app/myapp.dart';
import 'package:bl_runners_app/providers/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

// LOGS
var logger = Logger(printer: PrettyPrinter());
var loggerNoStack = Logger(printer: PrettyPrinter(methodCount: 0));

void main() async {
  // INICIAR HORÁRIO
  tz.initializeTimeZones();
  // INICIAR FIREBASE
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // INICIAR APP + PROVIDER
  runApp(MultiProvider(providers: AppProvider.provider, child: const MyApp()));
}
