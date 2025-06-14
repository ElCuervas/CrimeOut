import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/features/municipal_reports/data/datasources/municipal_report_remote_data_source.dart';
import 'package:frontend/features/municipal_reports/domain/entities/municipal_report.dart';

class MunicipalReporteCard extends StatefulWidget {
  final ReporteMunicipal reporte;// Se necesita para el PATCH
  final void Function(bool confiable, bool solucionado) onUpdateEstado;

  const MunicipalReporteCard({
    super.key,
    required this.reporte,
    required this.onUpdateEstado,
    
  });

  @override
  State<MunicipalReporteCard> createState() => _MunicipalReporteCardState();
}

class _MunicipalReporteCardState extends State<MunicipalReporteCard> {
  final _dataSource = ReporteMunicipalRemoteDataSource();
  bool _isUpdating = false;

  Future<void> _actualizarEstado({required bool confiable, required bool solucionado}) async {
    setState(() => _isUpdating = true);
    try {
      await _dataSource.actualizarEstadoReporte(
        id: widget.reporte.idReporte,
        confiable: confiable,
        solucionado: solucionado,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Estado del reporte actualizado')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.reporte;
    final f = DateFormat('dd/MM/yyyy HH:mm').format(r.fecha);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: r.imagenUrl.isNotEmpty
                  ? Image.network(r.imagenUrl, width: 80, height: 80, fit: BoxFit.cover)
                  : Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.tipoReporte, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(r.ubicacion),
                  Text(f, style: const TextStyle(fontSize: 12)),
                  Text(r.detalles, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.verified, color: r.confiable ? Colors.green : Colors.grey),
                  onPressed: _isUpdating ? null : () => _actualizarEstado(confiable: true, solucionado: r.solucionado),
                ),
                IconButton(
                  icon: Icon(Icons.check_circle, color: r.solucionado ? Colors.blue : Colors.grey),
                  onPressed: _isUpdating ? null : () => _actualizarEstado(confiable: r.confiable, solucionado: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}