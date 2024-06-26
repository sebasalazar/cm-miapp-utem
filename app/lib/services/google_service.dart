import 'package:app/services/rest_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Servicio de autenticación con Google utilizando `GoogleSignIn`.
/// Maneja el inicio y cierre de sesión de usuarios y almacena información
/// relevante en `SharedPreferences`.
class GoogleService {
  // Logger para registrar la información de desarrollo
  static final Logger _logger = Logger();

  // Instancia de GoogleSignIn con los scopes necesarios
  static final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['email', 'profile']);

  /// Método para iniciar sesión con Google.
  /// Devuelve `true` si el inicio de sesión es exitoso, `false` en caso contrario.
  static Future<bool> logIn() async {
    bool ok = false;
    try {
      // Intentar iniciar sesión con Google
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication auth = await account.authentication;
        final String idToken = auth.idToken ?? '';
        _logger.d('Google ID token $idToken');

        final String accessToken = auth.accessToken ?? '';
        _logger.d('Google Access Token $accessToken');

        if (idToken.isNotEmpty && accessToken.isNotEmpty) {
          // Guardar la información de autenticación en SharedPreferences
          SharedPreferences.getInstance().then((current) {
            current.setString('idToken', idToken);
            current.setString('email', account.email);
            current.setString('name', account.displayName ?? '');
            current.setString('image', account.photoUrl ?? '');
            // Llamar al servicio REST para registrar el acceso a la aplicación
            RestService.access(idToken);
          });
          ok = true;
        }
      }
    } catch (error, stackTrace) {
      ok = false;
      _logger.e(error);
      _logger.d(stackTrace.toString());
    }
    return ok;
  }

  /// Método para cerrar sesión con Google.
  static Future<void> logOut() async {
    try {
      await _googleSignIn.signOut();
      // Limpiar la información de autenticación de SharedPreferences
      SharedPreferences.getInstance().then((current) {
        current.setString('idToken', '');
        current.setString('email', '');
        current.setString('name', '');
        current.setString('image', '');
      });
      _logger.i('El usuario terminó su sesión');
    } catch (error, stackTrace) {
      _logger.e(error);
      _logger.d(stackTrace.toString());
    }
  }
}
