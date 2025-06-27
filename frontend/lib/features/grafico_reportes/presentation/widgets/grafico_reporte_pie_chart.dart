import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/entities/grafico_reporte.dart';

class GraficoReportePieChart extends StatefulWidget {
  final GraficoReporte data;

  const GraficoReportePieChart({super.key, required this.data});

  @override
  State<GraficoReportePieChart> createState() => _GraficoReportePieChartState();
}

class _GraficoReportePieChartState extends State<GraficoReportePieChart> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final total = data.microtrafico + data.actividadIlicita + data.maltratoAnimal + data.basural;
    if (total == 0) {
      return const Center(child: Text('No hay datos para mostrar'));
    }

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 45,
        pieTouchData: PieTouchData(
          touchCallback: (event, response) {
            setState(() {
              final touchedSection = response?.touchedSection;
              if (touchedSection != null && touchedSection.touchedSectionIndex != null) {
                _touchedIndex = touchedSection.touchedSectionIndex!;
              } else {
                _touchedIndex = -1;
              }
            });
          },
        ),
        sections: [
              PieChartSectionData(
                value: data.microtrafico.toDouble(),
                title: _touchedIndex == 0 ? 'Microtráfico: ${data.microtrafico}' : '',
                color: const Color(0xFFE14433), // Microtráfico = rojo
                radius: _touchedIndex == 0 ? 90 : 70,
                titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              PieChartSectionData(
                value: data.actividadIlicita.toDouble(),
                title: _touchedIndex == 1 ? 'Actividad ilícita: ${data.actividadIlicita}' : '',
                color: const Color(0xFFE1CF47), // Actividad ilícita = amarillo
                radius: _touchedIndex == 1 ? 90 : 70,
                titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              PieChartSectionData(
                value: data.maltratoAnimal.toDouble(),
                title: _touchedIndex == 2 ? 'Maltrato animal: ${data.maltratoAnimal}' : '',
                color: const Color(0xFF867DFF), // Maltrato animal = morado
                radius: _touchedIndex == 2 ? 90 : 70,
                titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              PieChartSectionData(
                value: data.basural.toDouble(),
                title: _touchedIndex == 3 ? 'Basural: ${data.basural}' : '',
                color: const Color(0xFFC3831D), // Basural = café
                radius: _touchedIndex == 3 ? 90 : 70,
                titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
      ),
    );
  }
}