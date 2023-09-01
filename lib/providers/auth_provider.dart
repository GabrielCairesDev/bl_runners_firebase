import 'package:bl_runners_firebase/models/modelo_de_usuario.dart';
import 'package:bl_runners_firebase/pages/pagina_entrar/controller/pagina_entrar_controlador.dart';
import 'package:bl_runners_firebase/pages/pagina_registrar/controller/pagina_registrar_controlador.dart';
import 'package:bl_runners_firebase/routes/rotas.dart';
import 'package:bl_runners_firebase/widgets/mensagens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User? _usuario;
  User? get usuario => _usuario;

  Future<void> _atualizarUsuario(User? novoUsuario) async {
    _usuario = novoUsuario;
    notifyListeners();
  }

  Future<void> criarUsuario(context, String email, String password, String nome) async {
    final registrarControlador = Provider.of<PaginaRegistrarControlador>(context, listen: false);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(nome);

      final modeloDeUsuario = ModeloDeUsuario(
        id: userCredential.user!.uid,
        nome: userCredential.user!.displayName.toString(),
        email: userCredential.user!.email.toString(),
        fotoUrl: '',
        genero: '',
        master: false,
        admin: false,
        autorizado: false,
        cadastroConcluido: false,
        dataNascimento: DateTime.now(),
      );

      FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid).set(modeloDeUsuario.toJson());

      await userCredential.user!.sendEmailVerification();
      await _atualizarUsuario(userCredential.user);
      await _mensagemContaCriada(context);

      registrarControlador.resetarValores();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        await _erroMensagem(context, 'A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        await _erroMensagem(context, 'Este e-mail já está em uso.');
      } else {
        await _erroMensagem(context, 'Erro durante o registro: ${e.message}');
      }
    } catch (e) {
      await _erroMensagem(context, 'Erro desconhecido: $e');
    }
    registrarControlador.atualizarCarregando();
  }

  Future<void> entrar(BuildContext context, String email, String password, bool entradaAutomatica) async {
    final entrarControlador = Provider.of<PaginaEntrarControlador>(context, listen: false);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (userCredential.user!.emailVerified == true) {
        final usarioDados = await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid).get();

        if (usarioDados.exists) {
          final modeloDeUsuario = ModeloDeUsuario.fromJson(usarioDados.data() as Map<String, dynamic>);

          if (modeloDeUsuario.cadastroConcluido == false) {
            if (context.mounted) context.pushReplacement(Rotas.concluir);
            entrarControlador.atualizarCarregando();
          } else {
            if (context.mounted) context.pushReplacement(Rotas.navegar);
            entrarControlador.atualizarCarregando();
          }
          await prefs.setBool("entradaAutomatica", entradaAutomatica);
          entrarControlador.resetarValores();
        } else {
          final modeloDeUsuario = ModeloDeUsuario(
            id: userCredential.user!.uid,
            nome: userCredential.user!.displayName.toString(),
            email: userCredential.user!.email.toString(),
            fotoUrl: '',
            genero: '',
            master: false,
            admin: false,
            autorizado: false,
            cadastroConcluido: false,
            dataNascimento: DateTime.now(),
          );
          await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid).set(modeloDeUsuario.toJson());

          if (context.mounted) await entrar(context, email, password, entradaAutomatica);
        }
      } else {
        if (context.mounted) _mensagemConfirmarEmail(context);
        entrarControlador.atualizarCarregando();
      }
      await _atualizarUsuario(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (context.mounted) await _erroMensagem(context, 'E-mail não registrado!');
        entrarControlador.atualizarCarregando();
      } else if (e.code == 'wrong-password') {
        if (context.mounted) await _erroMensagem(context, 'Senha inválida!');
        entrarControlador.atualizarCarregando();
      } else if (e.code == 'invalid-email') {
        if (context.mounted) await _erroMensagem(context, 'E-mail inválido!');
        entrarControlador.atualizarCarregando();
      } else {
        if (context.mounted) await _erroMensagem(context, 'Erro ao fazer login!');
        entrarControlador.atualizarCarregando();
      }
    } catch (e) {
      if (context.mounted) await _erroMensagem(context, 'Erro ao fazer login! $e');
      entrarControlador.atualizarCarregando();
    }
  }

  Future<void> autoEntrar(BuildContext context) async {
    User? usuario = FirebaseAuth.instance.currentUser;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool entradaAutomatica = prefs.getBool('entradaAutomatica') ?? false;

    if (usuario != null) {
      usuario.reload();
      try {
        if (entradaAutomatica == true && usuario.emailVerified == true) {
          final usarioDados = await FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).get();

          if (usarioDados.exists) {
            final dataMap = usarioDados.data();
            final modeloDeUsuario = ModeloDeUsuario.fromJson(dataMap!);

            await _atualizarUsuario(usuario);

            if (modeloDeUsuario.cadastroConcluido == false) {
              if (context.mounted) context.pushReplacement(Rotas.concluir);
            } else {
              if (context.mounted) context.pushReplacement(Rotas.navegar);
            }
          } else {
            final modeloDeUsuario = ModeloDeUsuario(
              id: usuario.uid,
              nome: usuario.displayName.toString(),
              email: usuario.email.toString(),
              fotoUrl: '',
              genero: '',
              master: false,
              admin: false,
              autorizado: false,
              cadastroConcluido: false,
              dataNascimento: DateTime.now(),
            );
            await FirebaseFirestore.instance.collection('usuarios').doc(usuario.uid).set(modeloDeUsuario.toJson());
            if (context.mounted) autoEntrar(context);
          }
        } else {
          if (context.mounted) sair(context);
        }
      } catch (e) {
        if (context.mounted) sair(context);
      }
    } else {
      if (context.mounted) sair(context);
    }
  }

  Future<void> sair(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("entradaAutomatica", false);
      if (context.mounted) context.pushReplacement(Rotas.entrar);
      await _atualizarUsuario(null);
    } catch (e) {
      if (context.mounted) await _erroMensagem(context, 'Erro ao sair: $e');
    }
  }

  Future<void> _mensagemContaCriada(context) async {
    Mensagens.caixaDeDialogo(
      context,
      titulo: "Parabéns!",
      texto: 'Sua conta foi criada com sucesso. Verifique o seu e-mail!',
      textoBotao: 'OK',
      onPressed: () async => Navigator.of(context).pop(),
    );
  }

  Future<void> _mensagemConfirmarEmail(context) async {
    User? user = FirebaseAuth.instance.currentUser;
    Mensagens.caixaDeDialogo(
      context,
      titulo: 'Atenção!',
      texto: 'Por favor, verifique o seu e-mail.\n ${user!.email}',
      textoBotao: 'ok',
      onPressed: () => Navigator.of(context).pop(),
    );
    await user.sendEmailVerification();
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _erroMensagem(BuildContext context, String mensagem) async => Mensagens.snackBar(context, mensagem);
}
