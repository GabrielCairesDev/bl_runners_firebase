import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/rotas.dart';
import '../../../models/modelo_de_usuario.dart';

class HomePageController extends ChangeNotifier {
  Future loginAutomatico(BuildContext context) async {
    final usuario = FirebaseAuth.instance.currentUser;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool entradaAutomatica = prefs.getBool('entradaAutomatica') ?? false;

    if (usuario != null) {
      try {
        await usuario.reload();

        if (entradaAutomatica == true && usuario.emailVerified == true) {
          final usarioDados = await FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).get();

          if (usarioDados.exists) {
            final modeloDeUsuario = ModeloDeUsuario.fromMap(usarioDados.data() as Map<String, dynamic>);
            if (modeloDeUsuario.cadastroConcluido == false || modeloDeUsuario.cadastroConcluido == null) {
              if (context.mounted) context.pushReplacement(Rotas.concluir);
            } else {
              if (context.mounted) context.pushReplacement(Rotas.navegar);
            }
          } else {
            final modeloDeUsuario = ModeloDeUsuario();
            await FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).set(modeloDeUsuario.toMap());
            if (context.mounted) loginAutomatico(context);
          }
        } else {
          if (context.mounted) desconectar(context, prefs);
        }
      } catch (e) {
        if (context.mounted) desconectar(context, prefs);
      }
    } else {
      if (context.mounted) desconectar(context, prefs);
    }
  }

  Future<void> desconectar(BuildContext context, SharedPreferences prefs) async {
    await FirebaseAuth.instance.signOut();
    prefs.setBool("entradaAutomatica", false);
    if (context.mounted) context.pushReplacement(Rotas.entrar);
  }
}
