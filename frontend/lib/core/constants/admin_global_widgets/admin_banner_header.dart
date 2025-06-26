import 'package:flutter/material.dart';

class AdminBannerHeader extends StatelessWidget {
  final String titulo;

  const AdminBannerHeader({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo con imagen topográfica
        Container(
          height: 140,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('icons/topo_wave.png'), // ← usa aquí tu imagen
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Texto centrado
        Positioned.fill(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40), // Para que no quede muy arriba
              child: Text(
                titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

