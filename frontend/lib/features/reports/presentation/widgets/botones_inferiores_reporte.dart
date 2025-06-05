import 'package:flutter/material.dart';

class BotonesInferioresReporte extends StatelessWidget {
  final VoidCallback onAgregarDetalles;
  final VoidCallback onEnviarReporte;

  const BotonesInferioresReporte({
    super.key,
    required this.onAgregarDetalles,
    required this.onEnviarReporte,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Botón “Agregar Detalles”
        Positioned(
          bottom: 100,
          left: 16,
          right: 16,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E2E3E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: onAgregarDetalles,
            icon: const Icon(Icons.image, color: Colors.white),
            label: const Text(
              'Agregar Detalles',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),

        // Botón “Enviar Reporte”
        Positioned(
          bottom: 32,
          left: 16,
          right: 16,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6B49F6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            onPressed: onEnviarReporte,
            child: const Text(
              'Enviar Reporte',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}