import 'package:flutter/material.dart';

class BotonReporte extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final Color colorFondo;
  final Color colorTexto;

  const BotonReporte({
    super.key,
    required this.texto,
    required this.onPressed,
    required this.colorFondo,
    this.colorTexto = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorFondo,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: colorTexto,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}