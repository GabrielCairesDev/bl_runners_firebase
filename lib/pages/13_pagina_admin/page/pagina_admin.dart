import 'package:flutter/material.dart';

class PaginaAdmin extends StatelessWidget {
  const PaginaAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administração'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.14,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0, 0),
                blurRadius: 5,
              ),
            ],
          ),
          child: const Row(
            children: [],
          ),
        ),
      ),
    );
  }
}
