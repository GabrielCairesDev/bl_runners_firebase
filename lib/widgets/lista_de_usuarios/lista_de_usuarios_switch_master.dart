import 'package:bl_runners_firebase/main.dart';
import 'package:bl_runners_firebase/pages/i_pagina_admin/controller/pagina_admin_controlador.dart';
import 'package:bl_runners_firebase/providers/firebase/snapshot/pegar_usuario_atual.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:flutter/material.dart';

class ListaDeUsuariosSwitchMaster extends StatefulWidget {
  const ListaDeUsuariosSwitchMaster({
    super.key,
    required this.master,
    required this.idUsuario,
    required this.controladorPaginaAdmin,
    required this.controladorPegarUsuarioAtual,
  });

  final bool master;
  final String idUsuario;
  final PegarUsuarioAtual controladorPegarUsuarioAtual;
  final PaginaAdminControlador controladorPaginaAdmin;

  @override
  State<ListaDeUsuariosSwitchMaster> createState() => _ListaDeUsuariosSwitchMasterState();
}

class _ListaDeUsuariosSwitchMasterState extends State<ListaDeUsuariosSwitchMaster> {
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    _switch = widget.master;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Switch(
              value: _switch,
              onChanged: (value) => atualizar(value),
            ),
            const Text('Master'),
          ],
        ),
      ),
    );
  }

  atualizar(value) async {
    await widget.controladorPaginaAdmin
        .editarMaster(
          idUsuario: widget.idUsuario,
          novoValor: value,
          idUsuarioAtual: widget.controladorPegarUsuarioAtual.usuarioAtual?.id ?? '',
          adminUsuarioAtual: widget.controladorPegarUsuarioAtual.usuarioAtual?.admin ?? false,
          masterUsuarioAtual: widget.controladorPegarUsuarioAtual.usuarioAtual?.master ?? false,
          autorizadoUsuarioAtual: widget.controladorPegarUsuarioAtual.usuarioAtual?.autorizado ?? false,
        )
        .then((value) => atualizarSucesso(value))
        .catchError(
          (onError) => atualizarErro(onError),
        );
  }

  atualizarSucesso(value) {
    Mensagens.mensagemSucesso(context, texto: value);
    logger.i(value);
    setState(() {
      _switch = !_switch;
    });
  }

  atualizarErro(onError) {
    Mensagens.mensagemErro(context, texto: onError);

    logger.e(onError);
    setState(() {
      _switch = _switch;
    });
  }
}
