import 'dart:math';

import 'package:app/models/faq.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Faq', () {
    test('fromJson()', () {
      Map<String, dynamic> jsonData = {
        'titulo': '¿Qué estoy haciendo?',
        'contenido': 'Una prueba unitaria'
      };

      Faq faq = Faq.fromJson(jsonData);
      expect(faq.titulo, '¿Qué estoy haciendo?');
      expect(faq.contenido, 'Una prueba unitaria');
    });

    test('toJson()', () {
      Faq faq = Faq(
          titulo: '¿Qué asignatura es esta?',
          contenido: 'Esta asignatura es Computación Móvil');

      Map<String, dynamic> jsonData = faq.toJson();

      expect(jsonData['titulo'], '¿Qué asignatura es esta?');
      expect(jsonData['contenido'], 'Esta asignatura es Computación Móvil');
    });
  });
}
