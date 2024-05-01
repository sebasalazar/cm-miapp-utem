import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.green,
        title: const Text('Electivo Computación Móvil'),
      ),
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
