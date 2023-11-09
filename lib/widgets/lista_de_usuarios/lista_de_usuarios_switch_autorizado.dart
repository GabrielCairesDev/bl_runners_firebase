import 'package:flutter/material.dart';
import 'package:bl_runners_app/main.dart';
import 'package:bl_runners_app/pages/i_pagina_admin/controller/pagina_admin_controlador.dart';
import 'package:bl_runners_app/widgets/mensagens.dart';

class ListaDeUsuariosSwitchAutorizado extends StatefulWidget {
  const ListaDeUsuariosSwitchAutorizado({
    Key? key,
    required this.listaUsuarioAutorizado,
    required this.listaUsuarioAdmin,
    required this.listaUsuarioMaster,
    required this.listaUsuarioid,
    required this.controladorPaginaAdmin,
    required this.usuarioAtualId,
    required this.usuarioAtualAdmin,
    required this.usuarioAtualMaster,
    required this.usuarioAtualAutorizado,
  }) : super(key: key);

  final String listaUsuarioid;
  final bool listaUsuarioAutorizado;
  final bool listaUsuarioAdmin;
  final bool listaUsuarioMaster;

  final String usuarioAtualId;
  final bool usuarioAtualAdmin;
  final bool usuarioAtualMaster;
  final bool usuarioAtualAutorizado;

  final PaginaAdminControlador controladorPaginaAdmin;

  @override
  State<ListaDeUsuariosSwitchAutorizado> createState() =>
      _ListaDeUsuariosSwitchAutorizadoState();
}

class _ListaDeUsuariosSwitchAutorizadoState
    extends State<ListaDeUsuariosSwitchAutorizado> {
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    _switch = widget.listaUsuarioAutorizado;
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
            const Text('Autorizado'),
          ],
        ),
      ),
    );
  }

  atualizar(value) async {
    await widget.controladorPaginaAdmin
        .editarAutorizado(
          listaUsuarioId: widget.listaUsuarioid,
          novoValor: value,
          usuarioAtualId: widget.usuarioAtualId,
          usuarioAtualAdmin: widget.usuarioAtualAdmin,
          usuarioAtualMaster: widget.usuarioAtualMaster,
          usuarioAtualAutorizado: widget.usuarioAtualAutorizado,
          listaUsuarioAdmin: widget.listaUsuarioAdmin,
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
