import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DataProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ModeloDeUsuario? modeloUsuario;

  // Metodo para pegar usuário Data
  Future<void> pegarUsuarioData() async {
    // Pegar usuário atual
    final user = FirebaseAuth.instance.currentUser;

    // Verificar se é nulo
    if (user != null) {
      // Pegar o documento com os dados
      final userData = _firestore.collection('usuarios').doc(user.uid).collection('perfil').doc('dados').snapshots();

      // Organizar os dados
      userData.listen(
        (snapshot) {
          if (snapshot.exists) {
            final data = snapshot.data() as Map<String, dynamic>;
            modeloUsuario = ModeloDeUsuario.fromJson(data);
            notifyListeners();
          } else {
            modeloUsuario = null;
          }
        },
      );
    } else {
      modeloUsuario = null;
    }
  }

  // Mensagem erro
  Future<void> _mensagemErro(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: texto,
      ),
    );
  }

  // Mensagem sucesso
  Future<void> _mensagemSucesso(BuildContext context, {required String texto}) async {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: texto,
      ),
    );
  }
}
