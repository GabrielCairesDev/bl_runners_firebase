import 'package:bl_runners_app/main.dart';
import 'package:bl_runners_app/pages/i_pagina_admin/controller/pagina_admin_controlador.dart';
import 'package:bl_runners_app/widgets/mensagens.dart';
import 'package:flutter/material.dart';

class ListaDeUsuariosSwitchMaster extends StatefulWidget {
  const ListaDeUsuariosSwitchMaster({
    super.key,
    required this.listaUsuarioMaster,
    required this.listaUsuarioId,
    required this.controladorPaginaAdmin,
    required this.listaUsuarioCadastroConcluido,
    required this.listaUsuarioAdmin,
    required this.listaUsuarioAutorizado,
    required this.usuarioAtualId,
    required this.usuarioAtualAdmin,
    required this.usuarioAtualMaster,
    required this.usuarioAtualAutorizado,
  });

  final String usuarioAtualId;
  final bool usuarioAtualAdmin;
  final bool usuarioAtualMaster;
  final bool usuarioAtualAutorizado;

  final String listaUsuarioId;
  final bool listaUsuarioMaster;
  final bool listaUsuarioCadastroConcluido;
  final bool listaUsuarioAutorizado;
  final bool listaUsuarioAdmin;

  final PaginaAdminControlador controladorPaginaAdmin;

  @override
  State<ListaDeUsuariosSwitchMaster> createState() =>
      _ListaDeUsuariosSwitchMasterState();
}

class _ListaDeUsuariosSwitchMasterState
    extends State<ListaDeUsuariosSwitchMaster> {
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    _switch = widget.listaUsuarioMaster;
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
          novoValor: value,
          listaUsuarioId: widget.listaUsuarioId,
          listaUsuarioCadastroConcluido: widget.listaUsuarioCadastroConcluido,
          listaUsuarioAdmin: widget.listaUsuarioAdmin,
          listaUsuarioAutorizado: widget.listaUsuarioAutorizado,
          usuarioAtualId: widget.usuarioAtualId,
          usuarioAtualAdmin: widget.usuarioAtualAdmin,
          usuarioAtualMaster: widget.usuarioAtualMaster,
          usuarioAtualAutorizado: widget.usuarioAtualAutorizado,
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
