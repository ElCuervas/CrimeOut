import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          // Header con curva
          ClipPath(
            clipper: _WaveClipper(),
            child: Container(
              height: 300,
              color: theme.colorScheme.primary,
            ),
          ),

          // Texto de bienvenida
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenido a CrimeOut',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                Text(
                  'Explicación de lo que es la app',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Botón Siguiente abajo a la derecha
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 24, bottom: 24),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                },
                label: const Text('Siguiente'),
                icon: const Icon(Icons.arrow_forward),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  textStyle: theme.textTheme.labelLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Clipper para la curva superior
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path()..lineTo(0, size.height - 60);
    p.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.5, size.height,
    );
    p.quadraticBezierTo(
      size.width * 0.75, size.height,
      size.width, size.height - 60,
    );
    p.lineTo(size.width, 0);
    return p..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> old) => false;
}