import 'package:bl_runners_firebase/pages/pagina_perfil/components/pagina_perfil_botao_editar.dart';
import 'package:flutter/material.dart';

import '../components/pagina_perfil_avatar.dart';
import '../components/pagina_perfil_nome.dart';
import '../components/pagina_perfil_recordes.dart';

class PaginaPerfil extends StatelessWidget {
  const PaginaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.95,
              width: double.infinity,
              color: const Color(0xFFc1d22b),
            ),
            const Column(
              children: [
                SizedBox(height: 88),
                PaginaPerfilAvatar(),
                SizedBox(height: 8),
                PaginaPerfilNome(),
                SizedBox(height: 8),
                PaginaPerfilRecordes(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: const PaginaPerfilBotaoEditar(),
    );
  }
}
