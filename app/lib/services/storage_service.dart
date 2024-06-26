import 'dart:convert';

import 'package:app/models/faq.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Servicio para manejar el almacenamiento de datos utilizando `SharedPreferences`.
class StorageService {
  // Logger para registrar la información de desarrollo
  static final Logger _logger = Logger();

  /// Método para cargar datos predeterminados en `SharedPreferences`.
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

  /// Método para obtener un valor específico almacenado en `SharedPreferences` por su clave.
  /// Devuelve el valor almacenado como una cadena de texto.
  static Future<String> getValue(String key) async {
    String value = '';
    await SharedPreferences.getInstance().then((current) {
      if (current.containsKey(key)) {
        value = current.getString(key) ?? '';
      }
    });
    return value;
  }

  /// Método para obtener una lista de datos almacenados en `SharedPreferences`.
  /// Devuelve una lista de objetos `Faq`.
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
