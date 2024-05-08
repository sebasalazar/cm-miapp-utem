import 'package:app/widgets/mi_barra.dart';
import 'package:app/widgets/mi_expansion.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MiBarra(titulo: 'Preguntas Frecuentes'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: const [
                  MiExpansion(
                      titulo: '¿Qué ramo es este?',
                      contenido:
                          'Este ramo es el electivo de computación móvil de la UTEM.'),
                  MiExpansion(
                      titulo: '¿Qué profe da el ramo?',
                      contenido: 'El viejesor es Sebastián Salazar')
                ],
              ))
        ],
      ),
    );
  }
}
