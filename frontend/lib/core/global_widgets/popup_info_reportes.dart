import 'package:flutter/material.dart';

class PopupInfoReportes extends StatelessWidget {
  const PopupInfoReportes({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                _buildTipoReporte(
                  color: const Color(0xFFE25449),
                  icon: Icons.medical_services,
                  titulo: 'Microtráfico:',
                  descripcion: 'Se avistan individuos\ntraficando drogas.',
                ),
                const SizedBox(height: 15),
                _buildTipoReporte(
                  color: const Color(0xFFE1C85B),
                  icon: Icons.warning,
                  titulo: 'Actividad ilícita:',
                  descripcion: 'Individuos\nparticipando en\nactividades ilícitas.',
                ),
                const SizedBox(height: 15),
                _buildTipoReporte(
                  color: const Color(0xFF8B7CF6),
                  icon: Icons.pets,
                  titulo: 'Maltrato Animal:',
                  descripcion: 'Animal descuidado o\nmaltratado.',
                ),
                const SizedBox(height: 15),
                _buildTipoReporte(
                  color: const Color(0xFFB8860B),
                  icon: Icons.delete,
                  titulo: 'Basural Detectado:',
                  descripcion: 'Individuos\ndepositando basura en\nun lugar no autorizado.',
                ),
              ],
            ),
          ),
          Positioned(
            top: 25,
            right: 25,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipoReporte({
    required Color color,
    required IconData icon,
    required String titulo,
    required String descripcion,
  }) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                descripcion,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Método estático para mostrar el popup desde cualquier parte de la aplicación
  static void mostrar(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Permite cerrar tocando fuera
      builder: (BuildContext context) => const PopupInfoReportes(),
    );
  }
}
