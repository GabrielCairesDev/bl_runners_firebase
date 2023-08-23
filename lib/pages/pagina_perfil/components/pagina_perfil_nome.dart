import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaginaPerfilNome extends StatefulWidget {
  const PaginaPerfilNome({super.key});

  @override
  State<PaginaPerfilNome> createState() => _PaginaPerfilNomeState();
}

class _PaginaPerfilNomeState extends State<PaginaPerfilNome> {
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
          return const Center(child: Text(''));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        usuario = ModeloDeUsuario.fromJson(data);

        return Center(
          child: Text(
            usuario!.nome,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.065,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.visible,
          ),
        );
      },
    );
  }
}
