import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/rotas.dart';

class PaginaConcluirControlador extends ChangeNotifier {
  sair(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) context.pushReplacement(Rotas.entrar);
  }
}
