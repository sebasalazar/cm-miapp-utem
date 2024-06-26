import 'package:app/widgets/mi_barra.dart';
import 'package:app/widgets/mi_menu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MiMenu(),
      appBar: const MiBarra(titulo: 'Página de inicio'),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/gerald.jpg'), fit: BoxFit.cover)),
        child: const Center(
            child: Text(
          'Hola soy un brujo',
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
