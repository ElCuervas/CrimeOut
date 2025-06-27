import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminBannerHeader extends StatelessWidget {
  final String titulo;

  const AdminBannerHeader({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: statusBarHeight + 100, // ⬅️ suma la altura de la barra superior
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('icons/topo_clean.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: statusBarHeight + 12),
        child: Center(
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
    );
  }
}