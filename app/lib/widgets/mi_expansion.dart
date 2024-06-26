import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class EstadoMiExpansion extends State<MiExpansion> {
  static final _logger = Logger();
  bool _expansible = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          widget.titulo,
          style: const TextStyle(fontSize: 17.0),
        ),
        onExpansionChanged: (expandido) {
          setState(() {
            _logger.d('Presioné $expandido');
            _expansible = expandido;
          });
        },
        initiallyExpanded: _expansible,
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 17.0),
              child: Text(
                widget.contenido,
                style: const TextStyle(fontSize: 13.0),
              ))
        ],
      ),
    );
  }
}

class MiExpansion extends StatefulWidget {
  final String titulo;
  final String contenido;

  const MiExpansion({super.key, required this.titulo, required this.contenido});

  @override
  State<StatefulWidget> createState() => EstadoMiExpansion();
}
