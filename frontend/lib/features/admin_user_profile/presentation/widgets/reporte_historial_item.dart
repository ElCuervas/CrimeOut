import 'package:flutter/material.dart';
import 'package:frontend/features/admin_user_profile/domain/entities/reporte_usuario.dart';

class ReporteHistorialItem extends StatelessWidget {
  final ReporteUsuario reporte;

  const ReporteHistorialItem({super.key, required this.reporte});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEBFD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // 🟥 Icono tipo de reporte
          Column(
            children: [
              Image.asset(
                'icons/${reporte.tipoReporte.toLowerCase()}.png',
                width: 32,
                height: 32,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.report),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.image),
            ],
          ),
          const SizedBox(width: 12),

          // 📄 Contenido del reporte
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    reporte.ubicacion,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    reporte.detalles,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // ✅ Iconos de confiabilidad y solución
          Column(
            children: [
              Icon(
                reporte.confiable ? Icons.check_circle : Icons.warning,
                color: reporte.confiable ? Colors.green : Colors.orange,
              ),
              const SizedBox(height: 12),
              Icon(
                reporte.solucionado ? Icons.check_circle : Icons.warning,
                color: reporte.solucionado ? Colors.green : Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}