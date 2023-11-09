import 'package:bl_runners_app/main.dart';
import 'package:bl_runners_app/pages/i_pagina_admin/controller/pagina_admin_controlador.dart';
import 'package:bl_runners_app/widgets/mensagens.dart';
import 'package:flutter/material.dart';

class ListaDeUsuariosSwitchAdmin extends StatefulWidget {
  const ListaDeUsuariosSwitchAdmin({
    super.key,
    required this.listaUsuarioAmin,
    required this.listaUsuarioid,
    required this.controladorPaginaAdmin,
    required this.listaUsuarioCadastroConcluido,
    required this.listaUsuarioAutorizado,
    required this.listaUsuarioMaster,
    required this.usuarioAtualId,
    required this.usuarioAtualAdmin,
    required this.usuarioAtualMaster,
    required this.usuarioAtualAutorizado,
  });

  final String listaUsuarioid;
  final bool listaUsuarioAmin;
  final bool listaUsuarioCadastroConcluido;
  final bool listaUsuarioAutorizado;
  final bool listaUsuarioMaster;

  final String usuarioAtualId;
  final bool usuarioAtualAdmin;
  final bool usuarioAtualMaster;
  final bool usuarioAtualAutorizado;

  final PaginaAdminControlador controladorPaginaAdmin;

  @override
  State<ListaDeUsuariosSwitchAdmin> createState() =>
      _ListaDeUsuariosSwitchAdminState();
}

class _ListaDeUsuariosSwitchAdminState
    extends State<ListaDeUsuariosSwitchAdmin> {
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    _switch = widget.listaUsuarioAmin;
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
            const Text('Admin'),
          ],
        ),
      ),
    );
  }

  atualizar(value) async {
    await widget.controladorPaginaAdmin
        .editarAdmin(
          listaUsuarioId: widget.listaUsuarioid,
          novoValor: value,
          usuarioAtualId: widget.usuarioAtualId,
          usuarioAtualAdmin: widget.usuarioAtualAdmin,
          usuarioAtualMaster: widget.usuarioAtualMaster,
          usuarioAtualAutorizado: widget.usuarioAtualAutorizado,
          listaUsuarioCadastroConcluido: widget.listaUsuarioCadastroConcluido,
          listaUsuarioAutorizado: widget.listaUsuarioAutorizado,
          listaUsuarioMaster: widget.listaUsuarioMaster,
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
