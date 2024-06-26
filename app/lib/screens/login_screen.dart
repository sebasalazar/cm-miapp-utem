import 'package:app/screens/error_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/services/google_service.dart';
import 'package:app/widgets/mi_barra.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// Esta clase representa una pantalla de inicio de sesión.
/// Es una subclase de `StatelessWidget` que utiliza varios paquetes y
/// servicios (firebase y api personalizada) para la autenticación de usuario.
class LoginScreen extends StatelessWidget {
  // Instancia de Logger para registrar mensajes de información y error.
  static final _logger = Logger();

  /// Constructor de la clase `LoginScreen`.
  const LoginScreen({super.key});

  /// El método `build` define la estructura y los componentes de la interfaz
  /// de usuario de esta pantalla. Utiliza un `Scaffold` que contiene una
  /// barra de aplicación personalizada (`MiBarra`) y un botón de inicio de sesión.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MiBarra(titulo: 'Accede a la aplicación'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: ElevatedButton(
            child: const Row(
              children: [Icon(Icons.g_mobiledata), Text('Login')],
            ),
            onPressed: () {
              // Llama al servicio de Google para iniciar sesión.
              GoogleService.logIn().then((result) {
                if (result) {
                  // Si la autenticación es exitosa, registra un mensaje de información
                  // y navega a la pantalla principal (`HomeScreen`).
                  _logger.i('Me pude autenticar');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }));
                } else {
                  // Si la autenticación falla, registra un mensaje de error
                  // y navega a una pantalla de error (`ErrorScreen`).
                  _logger.e('No fue posible autenticar');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ErrorScreen();
                  }));
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
