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
        final usarioDados = await FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).get();

        if (usarioDados.exists) {
          final modeloDeUsuario = ModeloDeUsuario.fromMap(usarioDados.data() as Map<String, dynamic>);

          if (entradaAutomatica == true && usuario.emailVerified == true) {
            if (modeloDeUsuario.cadastroConcluido == true) {
              if (context.mounted) {
                if (context.mounted) context.pushReplacement(Rotas.navegar);
              } else {
                if (context.mounted) context.pushReplacement(Rotas.concluir);
              }
            }
          } else {
            await FirebaseAuth.instance.signOut();
            prefs.setBool("entradaAutomatica", false);
            if (context.mounted) context.pushReplacement(Rotas.entrar);
          }
        } else {
          final modeloDeUsuario = ModeloDeUsuario(
            cadastroConcluido: false,
            master: false,
            admin: false,
            convidado: false,
            autorizado: false,
            tenis: 0,
            genero: 'Não Definido',
            camiseta: 'Não Definido',
            dataMascimento: DateTime.now(),
          );
          await FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).set(modeloDeUsuario.toMap()).then(
            (value) async {
              await loginAutomatico(context);
            },
          );
        }
      } catch (e) {
        await FirebaseAuth.instance.signOut();
        prefs.setBool("entradaAutomatica", false);
        if (context.mounted) context.pushReplacement(Rotas.entrar);
      }
    } else {
      await FirebaseAuth.instance.signOut();
      prefs.setBool("entradaAutomatica", false);
      if (context.mounted) context.pushReplacement(Rotas.entrar);
    }
  }
}
