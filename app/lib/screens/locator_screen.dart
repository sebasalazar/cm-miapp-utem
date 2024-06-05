import 'package:app/widgets/mi_barra.dart';
import 'package:app/widgets/mi_menu.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class LocatorScreenState extends State<LocatorScreen> {
  static final Logger _logger = Logger();

  late Future<Position> miPosicion;

  Future<Position> obtenerMiPosicion() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (LocationPermission.denied == locationPermission ||
        LocationPermission.unableToDetermine == locationPermission) {
      locationPermission = await Geolocator.requestPermission();
      if (LocationPermission.denied == locationPermission) {
        return Future.error('No se otorgó el permiso de ubicación');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    miPosicion = obtenerMiPosicion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MiMenu(),
        appBar: const MiBarra(titulo: 'Mi ubicación'),
        body: FutureBuilder<Position>(
          future: obtenerMiPosicion(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Row(
                children: [
                  Text('${snapshot.data!.latitude}'),
                  const Text(','),
                  Text('${snapshot.data!.longitude}')
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}

class LocatorScreen extends StatefulWidget {
  const LocatorScreen({super.key});

  @override
  State<StatefulWidget> createState() => LocatorScreenState();
}
