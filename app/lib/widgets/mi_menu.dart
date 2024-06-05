import 'package:app/screens/faq_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/locator_screen.dart';
import 'package:app/services/google_service.dart';
import 'package:app/services/storage_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class MiMenu extends StatelessWidget {
  static final _logger = Logger();

  const MiMenu({super.key});

  void _confirmacion(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('¿está seguro?',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green)),
            actions: [
              TextButton(
                  onPressed: () {
                    _logger.d('Que me arrepiento');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (Route<dynamic> route) => route.isFirst);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    _logger.d('Termino sesión');
                    GoogleService.logOut();
                    SystemNavigator.pop(animated: true);
                  },
                  child: const Text('Sí'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.green),
            accountName: FutureBuilder<String>(
              future: StorageService.getValue('name'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Caso final
                  return Text(snapshot.data ?? 'Usuario');
                } else if (snapshot.hasError) {
                  return const Text('Usuario');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            accountEmail: FutureBuilder<String>(
              future: StorageService.getValue('email'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Caso final
                  return Text(snapshot.data ?? 'usuario@utem.cl');
                } else if (snapshot.hasError) {
                  return const Text('usuario@utem.cl');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: FutureBuilder<String>(
                  future: StorageService.getValue('image'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      String url = snapshot.data ?? '';
                      if (url.isNotEmpty) {
                        return CachedNetworkImage(
                          imageUrl: url,
                          placeholder: (context, url) {
                            return const CircularProgressIndicator();
                          },
                          errorWidget: (context, url, error) {
                            _logger.e(error);
                            return const Icon(Icons.person);
                          },
                        );
                      } else {
                        return const Icon(Icons.person);
                      }
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.person);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              _logger.d('Me voy a inicio');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notes),
            title: const Text('FAQ'),
            onTap: () {
              _logger.d('Voy a preguntas frecuentes');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FaqScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Ubicación'),
            onTap: () {
              _logger.d('Voy a mi ubicación');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LocatorScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Salir'),
            onTap: () {
              _confirmacion(context);
            },
          )
        ],
      ),
    );
  }
}
