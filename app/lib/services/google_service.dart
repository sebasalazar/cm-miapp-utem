import 'package:app/services/rest_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleService {
  static final Logger _logger = Logger();
  static final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['email', 'profile']);

  static Future<bool> logIn() async {
    bool ok = false;
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication auth = await account.authentication;
        final String idToken = auth.idToken ?? '';
        _logger.d('Google ID token $idToken');

        final String accessToken = auth.accessToken ?? '';
        _logger.d('Google Access Token $accessToken');

        if (idToken.isNotEmpty && accessToken.isNotEmpty) {
          SharedPreferences.getInstance().then((current) {
            current.setString('idToken', idToken);
            current.setString('email', account.email);
            current.setString('name', account.displayName ?? '');
            current.setString('image', account.photoUrl ?? '');
            // Por simplicidad marcamos el ingreso en este punto
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

  static Future<void> logOut() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signOut();
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
