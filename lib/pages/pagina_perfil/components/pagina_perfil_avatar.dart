import 'package:bl_runners_firebase/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaPerfilAvatar extends StatelessWidget {
  const PaginaPerfilAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: ClipOval(
        child: fotoPerfil(context),
      ),
    );
  }

  fotoPerfil(BuildContext context) {
    final controladorDataProvider = Provider.of<DataProvider>(context);
    final foto = controladorDataProvider.modeloUsuario?.fotoUrl;

    if (foto == null || foto.isEmpty) {
      return Image.asset('assets/images/avatar.png');
    }

    return Image.network(
      foto.toString(),
      fit: BoxFit.cover,
    );
  }
}
