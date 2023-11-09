import 'package:bl_runners_app/pages/b_pagina_registrar_usuario/controller/pagina_registrar_controlador.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PaginaRegistrarCheckBox extends StatefulWidget {
  const PaginaRegistrarCheckBox({super.key, required this.controlador});

  final PaginaRegistrarUsuarioControlador controlador;

  @override
  State<PaginaRegistrarCheckBox> createState() =>
      _PaginaRegistrarCheckBoxState();
}

class _PaginaRegistrarCheckBoxState extends State<PaginaRegistrarCheckBox> {
  bool _checkBox = false;

  @override
  void initState() {
    super.initState();
    _checkBox = widget.controlador.termosAceito;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _checkBox,
          onChanged: (bool? value) {
            setState(() {
              _checkBox = value!;
            });
            atualizarCheckBox(value);
          },
        ),
        Flexible(
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Li e estou de acordo com o ',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'Termo de Uso e Política de Privacidade',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => termosPoliticaPrivacidade(context),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  atualizarCheckBox(value) {
    widget.controlador.termosAceito = value;
  }

  Future<dynamic> termosPoliticaPrivacidade(BuildContext context) {
    return showModalBottomSheet<dynamic>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return const Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Termo de Uso e Política de Privacidade',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Markdown(data: ''' 
**Aceitação dos Termos**

Ao usar o aplicativo, você confirma que leu, entendeu e concordou em ficar vinculado por estes Termos, juntamente com nossa Política de Privacidade.

**Responsabilidade pelos Dados**

Você é inteiramente responsável pelos dados que envia através do aplicativo. Garante que tem todos os direitos necessários para fornecer esses dados e que eles estão em conformidade com as leis aplicáveis.

**Privacidade**

Nós valorizamos a sua privacidade. As informações que você nos fornece serão usadas de acordo com nossa Política de Privacidade. Ao utilizar o aplicativo, você concorda com a coleta, armazenamento e uso de suas informações, conforme descrito na Política de Privacidade.

**Segurança**

Fazemos todos os esforços para manter a segurança e a confidencialidade dos dados que você envia através do aplicativo. No entanto, não podemos garantir a segurança absoluta dos dados transmitidos pela internet.

**Uso Adequado**

Você concorda em usar o aplicativo apenas para fins legais e adequados. Não deve usar o aplicativo de forma que possa danificar, desabilitar, sobrecarregar ou prejudicar o aplicativo.

**Modificações**

Reservamo-nos o direito de modificar ou interromper o aplicativo a qualquer momento, temporária ou permanentemente, com ou sem aviso prévio. Não seremos responsáveis perante você ou terceiros por qualquer modificação, suspensão ou interrupção do aplicativo.

**Isenção de Responsabilidade**

O aplicativo é fornecido "como está", sem garantias de qualquer tipo, expressas ou implícitas. Não garantimos que o aplicativo será ininterrupto, seguro ou livre de erros.

**Contato**
                
Se você tiver alguma dúvida sobre estes Termos, entre em contato: [Linktr.ee/gabrielcaires](https://linktr.ee/gabrielcaires)
                '''),
              ),
            )
          ],
        );
      },
    );
  }
}
