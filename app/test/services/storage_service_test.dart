import 'dart:convert';

import 'package:app/models/faq.dart';
import 'package:app/services/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('StorageService', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('cargar()', () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      StorageService.cargar();
      await StorageService.getDatos();

      String? llave = preferences.getString('llave');
      expect(llave, isNotNull);

      final List<dynamic> decodificado = json.decode(llave!);
      expect(decodificado.length, 2);
      expect(decodificado[0]['titulo'], '¿Qué ramo es este?');
      expect(decodificado[1]['titulo'], '¿Qué profe da el ramo?');
    });

    test('getValue() caso bueno', () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('Universidad', 'UTEM');
      String str = await StorageService.getValue('Universidad');
      expect(str, 'UTEM');
    });

    test('getValue() caso malo', () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String str = await StorageService.getValue('Electivo');
      expect(str, '');
    });

    test('getDatos()', () async {
      StorageService.cargar();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<Faq> list = await StorageService.getDatos();
      expect(list.length, 2);
      expect(list[0].titulo, '¿Qué ramo es este?');
      expect(list[1].titulo, '¿Qué profe da el ramo?');
    });
  });
}
