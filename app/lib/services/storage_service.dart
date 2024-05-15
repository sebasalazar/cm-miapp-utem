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

  static Future<String> getValue(String key) async {
    String value = '';
    await SharedPreferences.getInstance().then((current) {
      if (current.containsKey(key)) {
        value = current.getString(key) ?? '';
      }
    });
    return value;
  }

  static Future<List<Faq>> getDatos() async {
    List<Faq> lista = [];
    String valor = await getValue('llave');
    if (valor.isNotEmpty) {
      List<dynamic> objetos = json.decode(valor);
      if (objetos.isNotEmpty) {
        lista = objetos.map((elemento) {
          return Faq.fromJson(elemento);
        }).toList();
      }
    }
    return lista;
  }
}
