import 'package:app/models/jwt_vo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Objeto JwtVO', () {
    test('toJson()', () {
      const String baseJwt =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';

      JwtVo vo = JwtVo();
      vo.jwt = baseJwt;
      Map<String, dynamic> json = vo.toJson();

      expect(json['jwt'], baseJwt);
    });
  });
}
