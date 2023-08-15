import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/modelo_de_usuario.dart';

class PaginaNavegacaoAvatar extends StatefulWidget {
  const PaginaNavegacaoAvatar({super.key});

  @override
  State<PaginaNavegacaoAvatar> createState() => _PaginaNavegacaoAvatarState();
}

class _PaginaNavegacaoAvatarState extends State<PaginaNavegacaoAvatar> {
  User? user;
  ModeloDeUsuario? usuario;
  late Stream<DocumentSnapshot> _usersStream;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _usersStream = FirebaseFirestore.instance.collection('usuarios').doc(user!.uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: ClipOval(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        usuario = ModeloDeUsuario.fromJson(data);

        return SizedBox(
          width: 24,
          height: 24,
          child: ClipOval(
            child: Image.network(
              usuario!.fotoUrl!,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
