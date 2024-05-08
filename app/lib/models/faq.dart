class Faq {
  String titulo;
  String contenido;

  Faq({required this.titulo, required this.contenido});

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(titulo: json['titulo'], contenido: json['contenido']);
  }

  Map<String, dynamic> toJson() {
    return {"titulo": titulo, "contenido": contenido};
  }
}
