import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/features/municipal_reports/data/datasources/municipal_report_remote_data_source.dart';
import 'package:frontend/features/municipal_reports/domain/entities/municipal_report.dart';
import 'dart:convert';

class MunicipalReporteCard extends StatefulWidget {
  final ReporteMunicipal reporte;
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

  // Estado local
  late bool _confiable;
  late bool _solucionado;

  @override
  void initState() {
    super.initState();
    _confiable = widget.reporte.confiable;
    _solucionado = widget.reporte.solucionado;
  }

  Future<void> _actualizarEstado({required bool confiable, required bool solucionado}) async {
    setState(() => _isUpdating = true);
    try {
      await _dataSource.actualizarEstadoReporte(
        id: widget.reporte.idReporte,
        confiable: confiable,
        solucionado: solucionado,
      );
      setState(() {
        _confiable = confiable;
        _solucionado = solucionado;
      });
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

  Color _colorPorTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'basural':
        return Colors.brown;
      case 'microtráfico':
        return Colors.red;
      case 'maltrato animal':
        return Colors.purple;
      case 'actividad ilícita':
        return Colors.yellow[700]!;
      default:
        return Colors.grey;
    }
  }

  Widget _buildImagen(String imagen) {
    if (imagen.isEmpty) {
      return Container(
        width: 80,
        height: 80,
        color: Colors.grey[300],
        child: const Icon(Icons.image_not_supported),
      );
    }

    try {
      if (imagen.startsWith('http')) {
        return Image.network(
          imagen,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
        );
      } else {
        final decoded = base64Decode(imagen.split(',').last.trim());
        return Image.memory(
          decoded,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      print('⚠️ Error al decodificar imagen: $e');
      return const Icon(Icons.broken_image);
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
              child: _buildImagen(r.imagenUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                          color: _colorPorTipo(r.tipoReporte),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Text(
                        r.tipoReporte,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
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
                  icon: Icon(Icons.verified, color: _confiable ? Colors.green : const Color.fromARGB(255, 226, 52, 52)),
                  onPressed: _isUpdating
                      ? null
                      : () => _actualizarEstado(confiable: !_confiable, solucionado: _solucionado),
                ),
                IconButton(
                  icon: Icon(Icons.check_circle, color: _solucionado ? Colors.blue : Colors.grey),
                  onPressed: _isUpdating
                      ? null
                      : () => _actualizarEstado(confiable: _confiable, solucionado: !_solucionado),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}