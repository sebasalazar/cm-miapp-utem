import 'package:app/models/faq.dart';
import 'package:app/services/storage_service.dart';
import 'package:app/widgets/mi_barra.dart';
import 'package:app/widgets/mi_expansion.dart';
import 'package:app/widgets/mi_menu.dart';
import 'package:flutter/material.dart';

class _EstadoFaqScreen extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MiMenu(),
      appBar: const MiBarra(titulo: 'Preguntas Frecuentes'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: FutureBuilder<List<Faq>>(
                future: StorageService.getDatos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    // Caso Feliz
                    List<Faq> data = snapshot.data ?? [];
                    if (data.isNotEmpty) {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return MiExpansion(
                                titulo: data.elementAt(index).titulo,
                                contenido: data.elementAt(index).contenido);
                          });
                    } else {
                      return const Text('La lista no tiene datos');
                    }
                  } else if (snapshot.hasError) {
                    // Caso triste
                    return const Text('No fue posible cargar los datos');
                  } else {
                    // Cualquier otro caso
                    return const CircularProgressIndicator();
                  }
                },
              ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    StorageService.cargar();
  }
}

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EstadoFaqScreen();
}
