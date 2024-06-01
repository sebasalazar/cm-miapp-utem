import 'package:app/screens/error_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/services/google_service.dart';
import 'package:app/widgets/mi_barra.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatelessWidget {
  static final _logger = Logger();

  const LoginScreen({super.key});

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
              GoogleService.logIn().then((result) {
                if (result) {
                  _logger.i('Me pude autenticar');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }));
                } else {
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
