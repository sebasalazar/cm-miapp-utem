import 'package:app/screens/error_screen.dart';
import 'package:app/screens/faq_screen.dart';
import 'package:app/services/google_service.dart';
import 'package:app/widgets/mi_barra.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatelessWidget {
  static final _logger = Logger();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  LoginScreen({super.key});

  Future<bool> _manejarAutenticacion() async {
    bool auth = false;
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication authentication =
            await account.authentication;
        final String idToken = authentication.idToken ?? '';
        final String accessToken = authentication.accessToken ?? '';
        auth = (idToken.isNotEmpty || accessToken.isNotEmpty);
        _logger.d(idToken);
        _logger.d(accessToken);
      }
    } catch (error, stackTrace) {
      auth = false;
      _logger.e('Error al iniciar sesión en Google: ${error.toString()}');
      _logger.d(stackTrace.toString(), stackTrace: stackTrace);
    }
    return auth;
  }

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
                    return const FaqScreen();
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
