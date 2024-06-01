import 'package:app/models/jwt_vo.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class RestService {
  static const String _mime = 'application/json';
  static const String _baseUrl = 'https://api.sebastian.cl/Auth';
  static const Map<String, String> _headers = {
    'accept': _mime,
    'X-API-TOKEN': 'sebastian.cl',
    'X-API-KEY': 'aaa-bbb-ccc-ddd'
  };

  static final Logger _logger = Logger();
  static final Dio _client = Dio();

  Future<void> access(String idToken) async {
    try {
      _logger.d('Marcando acceso de: $idToken');
      JwtVo vo = JwtVo();
      vo.jwt = idToken;
      const String url = '$_baseUrl/v1/access/login';
      _client.interceptors.add(LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true));
      Response<String> response = await _client.post(url,
          data: vo.toJson(), options: Options(headers: _headers));
      final int status = response.statusCode ?? 400;
      final String jsonResponse = response.data ?? '';
      if (status >= 200 && status < 300) {
        _logger.i('Respuesta correcta con código $status');
      } else {
        _logger.e('Respuesta incorrecta con código $status');
        _logger.e(jsonResponse);
      }
    } catch (error, stackTrace) {
      _logger.e(error.toString());
      _logger.d(stackTrace.toString());
    }
  }
}
