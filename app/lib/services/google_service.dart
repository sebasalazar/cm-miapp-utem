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
          });
        }
      }
    } catch (error, stackTrace) {
      ok = false;
      _logger.e(error);
      _logger.d(stackTrace.toString());
    }
    return ok;
  }
}
