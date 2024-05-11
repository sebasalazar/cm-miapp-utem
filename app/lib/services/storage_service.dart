import 'dart:convert';

import 'package:app/models/faq.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final Logger _logger = Logger();

  static void cargar() {
    List<Faq> lista = [];
    lista.add(Faq(
        titulo: '¿Qué ramo es este?',
        contenido:
            'Este ramo es el electivo de computación móvil de la UTEM.'));
    lista.add(Faq(
        titulo: '¿Qué profe da el ramo?',
        contenido: 'El viejesor es Sebastián Salazar'));

    SharedPreferences.getInstance().then((actual) {
      actual.setString("llave", json.encode(lista));
    });
  }

  static Future<List<Faq>> getDatos() async {
    List<Faq> lista = [];
    await SharedPreferences.getInstance().then((actual) {
      final String valor = actual.getString('llave') ?? '';
      if (valor.isNotEmpty) {
        List<dynamic> objetos = json.decode(valor);
        if (objetos.isNotEmpty) {
          lista = objetos.map((elemento) {
            return Faq.fromJson(elemento);
          }).toList();
        }
      }
    });
    return lista;
  }
}
