import 'package:flutter/material.dart';
import 'package:frontend/features/admin_reportes/domain/entities/reporte_sospechoso.dart';

class ReporteSospechosoCard extends StatelessWidget {
  final ReporteSospechoso reporte;
  final VoidCallback onVerPerfil;

  const ReporteSospechosoCard({
    super.key,
    required this.reporte,
    required this.onVerPerfil,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF2F1FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono de tipo reporte
            Column(
              children: [
                Image.asset(
                  'icons/${reporte.tipoReporte.toLowerCase().replaceAll(' ', '_')}_circulo.png',
                  width: 32,
                  height: 32,
                ),
                const SizedBox(height: 25),
                Image.network(
                  reporte.imagenUrl,
                  width: 40,
                  height: 40,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                ),
              ],
            ),
            const SizedBox(width: 12),
            // Información
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' Descripción',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reporte.detalles,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Icono usuario + botón
            Column(
              children: [
                const Icon(Icons.person, size: 36),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onVerPerfil,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B49F6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: const Text('Ver Perfil'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}