import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/rotas.dart';

class HomePageController extends ChangeNotifier {
  loginAutomatico(BuildContext context) async {
    var usuario = FirebaseAuth.instance.currentUser;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool entradaAutomatica = prefs.getBool('entradaAutomatica') ?? false;

    if (entradaAutomatica == true && usuario != null && usuario.emailVerified == true) {
      if (context.mounted) context.pushReplacement(Rotas.navegar);
    } else {
      FirebaseAuth.instance.signOut();
      prefs.setBool("entradaAutomatica", false);
      if (context.mounted) context.pushReplacement(Rotas.entrar);
    }
  }
}
