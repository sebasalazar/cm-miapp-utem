import 'package:app/widgets/mi_barra.dart';
import 'package:app/widgets/mi_menu.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:logger/logger.dart';

/// Clase `PhotoScreen` que representa la pantalla de tomar una foto.
/// Es un `StatefulWidget` que permite mantener el estado del controlador
/// de la cámara y otros datos.
class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PhotoScreen();
}

/// Estado asociado a `PhotoScreen`, maneja la lógica y el estado de la cámara.
class _PhotoScreen extends State<PhotoScreen> {
  // Logger para loguear la información de desarrollo
  static final Logger _logger = Logger();

  // Controlador para la cámara
  late CameraController _controlador;

  // Inicializador del controlador de la cámara
  Future<void>? _inicializadorControlador;

  // Listado de cámaras disponibles
  late List<CameraDescription> camaras;

  // La cámara a usar
  late CameraDescription primeraCamara;

  /// Método para inicializar las cámaras.
  Future<void> inicializadorCamaras() async {
    try {
      camaras = await availableCameras();
      primeraCamara = camaras.first;
      _controlador = CameraController(primeraCamara, ResolutionPreset.max);

      _inicializadorControlador = _controlador.initialize();

      if (mounted) {
        setState(() {
          _logger.i("Vista cargada");
        });
      }
    } catch (error) {
      _logger.e("Error al iniciar cámaras", error: error);
    }
  }

  @override
  void initState() {
    super.initState();
    inicializadorCamaras();
  }

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  /// Método para tomar una foto y guardarla en la galería.
  Future<void> _tomarFoto() async {
    try {
      // Esperar que la cámara esté lista y disponible
      await _inicializadorControlador;

      // Tomar la foto
      XFile foto = await _controlador.takePicture();
      bool ok =
          await GallerySaver.saveImage(foto.path, albumName: 'DCIM') ?? false;
      _logger.d('Imagen guardada $ok');

      if (mounted) {
        if (ok) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('La imagen fue guardada correctamente')));
        }
      }
    } catch (error, stackTrace) {
      _logger.e("Error al tomar foto", error: error, stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MiMenu(),
      appBar: const MiBarra(titulo: 'Tomar una foto'),
      body: FutureBuilder<void>(
        future: _inicializadorControlador,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controlador);
          } else if (snapshot.hasError) {
            return Center(
                child:
                    Text('Hay un error al usar la cámara: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _tomarFoto, child: const Icon(Icons.camera)),
    );
  }
}
