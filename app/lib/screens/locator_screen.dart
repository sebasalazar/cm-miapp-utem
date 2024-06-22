import 'package:app/widgets/mi_barra.dart';
import 'package:app/widgets/mi_menu.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

/// Esta clase representa el estado de la pantalla LocatorScreen que muestra
/// la ubicación del usuario.
class LocatorScreenState extends State<LocatorScreen> {
  /// La librería que maneja el log de la aplicación
  static final Logger _logger = Logger();

  /// Indica si el mapa ha sido creado.
  bool isMapCreated = false;

  /// Controlador que maneja los mapas de Google.
  late GoogleMapController _miMapa;

  /// La promesa de la ubicación del usuario
  late Future<LatLng> _center;

  /// Obtiene la posición actual del usuario
  ///
  /// Comprueba y solicita los permisos de ubicación (en caso de ser necesario).
  /// Retorna la latitud y longitud del usuario en un objeto de tipo [LatLng]
  /// En caso de no tener permiso, se retornará un error.
  Future<LatLng> obtenerMiPosicion() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (LocationPermission.denied == locationPermission ||
        LocationPermission.unableToDetermine == locationPermission) {
      locationPermission = await Geolocator.requestPermission();
      if (LocationPermission.denied == locationPermission) {
        return Future.error('No se otorgó el permiso de ubicación');
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  @override
  void initState() {
    super.initState();
    _center = obtenerMiPosicion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MiMenu(),
        appBar: const MiBarra(titulo: 'Mi ubicación'),
        body: FutureBuilder<LatLng>(
          future: _center,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              LatLng? punto = snapshot.data;
              if (punto != null) {
                Set<Marker> markers = {};
                markers.add(
                    Marker(markerId: const MarkerId('Aquí'), position: punto));

                return Stack(
                  children: [
                    GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: punto, zoom: 17),
                        onMapCreated: (GoogleMapController controller) {
                          _miMapa = controller;
                          isMapCreated = true;
                        },
                        markers: markers),
                    Positioned(
                        child: FloatingActionButton(
                      onPressed: () {
                        _miMapa.animateCamera(
                            CameraUpdate.newLatLngZoom(punto, 19));
                      },
                      child: const Icon(Icons.refresh),
                    ))
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}

/// Widget que representa la pantalla de ubicación del usuario
class LocatorScreen extends StatefulWidget {
  const LocatorScreen({super.key});

  @override
  State<StatefulWidget> createState() => LocatorScreenState();
}
