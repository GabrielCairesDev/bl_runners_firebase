import 'package:flutter/material.dart';

class HomePageController extends ChangeNotifier {}
// Future loginAutomatico(BuildContext context) async {
  //   User? usuario = FirebaseAuth.instance.currentUser;

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool entradaAutomatica = prefs.getBool('entradaAutomatica') ?? false;

  //   if (usuario != null) {
  //     usuario.reload();
  //     try {
  //       if (entradaAutomatica == true && usuario.emailVerified == true) {
  //         final usarioDados = await FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).get();

  //         if (usarioDados.exists) {
  //           final dataMap = usarioDados.data();
  //           final modeloDeUsuario = ModeloDeUsuario.fromJson(dataMap!);

  //           if (modeloDeUsuario.cadastroConcluido == false) {
  //             if (context.mounted) context.pushReplacement(Rotas.concluir);
  //           } else {
  //             if (context.mounted) context.pushReplacement(Rotas.navegar);
  //           }
  //         } else {
  //           final modeloDeUsuario = ModeloDeUsuario(
  //             id: usuario.uid,
  //             nome: usuario.displayName.toString(),
  //             email: usuario.email.toString(),
  //             fotoUrl: '',
  //             genero: '',
  //             master: false,
  //             admin: false,
  //             autorizado: false,
  //             cadastroConcluido: false,
  //             dataNascimento: DateTime.now(),
  //           );
  //           await FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).set(modeloDeUsuario.toJson());
  //           if (context.mounted) loginAutomatico(context);
  //         }
  //       } else {
  //         if (context.mounted) desconectar(context, prefs);
  //       }
  //     } catch (e) {
  //       if (context.mounted) desconectar(context, prefs);
  //     }
  //   } else {
  //     if (context.mounted) desconectar(context, prefs);
  //   }
  // }

  // Future<void> desconectar(BuildContext context, SharedPreferences prefs) async {
  //   await FirebaseAuth.instance.signOut();
  //   prefs.setBool("entradaAutomatica", false);
  //   if (context.mounted) context.pushReplacement(Rotas.entrar);
  // }