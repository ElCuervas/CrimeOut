import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthHeader extends StatelessWidget {
  final String title;

  const AuthHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagen ya curva, sin necesidad de ClipPath
        Container(
  height: 350,
  width: double.infinity,
  decoration: const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('icons/topo_wave.png'),
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
    ),
  ),
),
        Positioned(
          left: 24,
          bottom: 24,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.grey[900],
            ),
          ),
        ),
      ],
    );
  }
}