import 'package:flutter/material.dart';

class MiBarra extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const MiBarra({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: const TextStyle(color: Colors.white),
      backgroundColor: Colors.green,
      title: Text(titulo),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

