
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/grafico_reporte.dart';

class GraficoReportePieChart extends StatelessWidget {
  final GraficoReporte data;

  const GraficoReportePieChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.microtrafico + data.actividadIlicita + data.maltratoAnimal + data.basural;
    if (total == 0) {
      return const Center(child: Text('No hay datos para mostrar'));
    }

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            value: data.microtrafico.toDouble(),
            title: 'Microtráfico',
            radius: 60,
            titleStyle: const TextStyle(fontSize: 14),
          ),
          PieChartSectionData(
            value: data.actividadIlicita.toDouble(),
            title: 'Actividad ilícita',
            radius: 60,
            titleStyle: const TextStyle(fontSize: 14),
          ),
          PieChartSectionData(
            value: data.maltratoAnimal.toDouble(),
            title: 'Maltrato animal',
            radius: 60,
            titleStyle: const TextStyle(fontSize: 14),
          ),
          PieChartSectionData(
            value: data.basural.toDouble(),
            title: 'Basural',
            radius: 60,
            titleStyle: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
