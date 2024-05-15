import 'package:app/widgets/mi_barra.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MiBarra(titulo: 'Ha ocurrido un error'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 100, color: Colors.red),
            Text('Ha ocurrido un error',
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
