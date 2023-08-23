import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaginaPerfilAvatar extends StatefulWidget {
  const PaginaPerfilAvatar({super.key});

  @override
  State<PaginaPerfilAvatar> createState() => _PaginaPerfilAvatarState();
}

class _PaginaPerfilAvatarState extends State<PaginaPerfilAvatar> {
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
        if (snapshot.hasError) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.width * 0.5,
            child: const ClipOval(
              child: Image(
                image: AssetImage('assets/images/avatar.png'),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
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
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: ClipOval(
            child: Image.network(
              usuario!.fotoUrl,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
