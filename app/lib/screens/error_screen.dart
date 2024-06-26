import 'package:app/widgets/mi_barra.dart';
import 'package:flutter/material.dart';

/// Pantalla de error que se muestra cuando ocurre un error en la aplicación.
/// Es un widget sin estado (`StatelessWidget`).
class ErrorScreen extends StatelessWidget {
  /// Constructor de la clase `ErrorScreen`.
  const ErrorScreen({super.key});

  /// Construye y devuelve la interfaz de usuario para la pantalla de error.
  /// Utiliza un `Scaffold` que contiene una barra de aplicación personalizada (`MiBarra`)
  /// y un cuerpo centrado que muestra un ícono de error y un mensaje de error.
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
