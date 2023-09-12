import 'package:bl_runners_firebase/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaNavegacaoAvatar extends StatefulWidget {
  const PaginaNavegacaoAvatar({super.key});

  @override
  State<PaginaNavegacaoAvatar> createState() => _PaginaNavegacaoAvatarState();
}

class _PaginaNavegacaoAvatarState extends State<PaginaNavegacaoAvatar> {
  @override
  // void initState() {
  //   final controladorDataProvider = Provider.of<DataProvider>(context, listen: false);
  //   controladorDataProvider.usuarioDados();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: ClipOval(
        child: fotoPerfil(),
      ),
    );
  }

  fotoPerfil() {
    final controladorDataProvider = Provider.of<DataProvider>(context);
    if (controladorDataProvider.modeloUsuario?.fotoUrl == null || controladorDataProvider.modeloUsuario!.fotoUrl.isEmpty) {
      return Image.asset('assets/images/avatar.png');
    } else {
      return Image.network(
        controladorDataProvider.modeloUsuario!.fotoUrl.toString(),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/avatar.png');
        },
      );
    }
  }
}
