/// Clase que representa una pregunta Frecuente
class Faq {
  /// El título con el que se identifica la pregunta frecuenta.
  String titulo;

  /// El contenido que da respuesta a dicha pregunta
  String contenido;

  /// Constructor de la clase [Faq]
  ///
  /// El parámetro [titulo] define la pregunta
  /// El parámetro [contenido] define la respuesta
  Faq({required this.titulo, required this.contenido});

  /// Crea una instancia de tipo [Faq] a partir de un [Map] Json.
  ///
  /// El parámetro [json] es un [Map] que contiene la información del objeto [Faq] en formato json.
  /// Retorna una nueva instancia de [Faq] con los datos proporcionados.
  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(titulo: json['titulo'], contenido: json['contenido']);
  }

  /// Convierte una instancia de [Faq] en un [Map] Json.
  ///
  /// Retorna un [Map] con los datos de la instancia en formato Json.
  Map<String, dynamic> toJson() {
    return {"titulo": titulo, "contenido": contenido};
  }
}
