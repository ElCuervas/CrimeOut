import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/grafico_provider.dart';
import '../widgets/grafico_reporte_pie_chart.dart';

class MunicipalGraficoScreen extends ConsumerStatefulWidget {
  const MunicipalGraficoScreen({super.key});

  @override
  ConsumerState<MunicipalGraficoScreen> createState() => _MunicipalGraficoScreenState();
}

class _MunicipalGraficoScreenState extends ConsumerState<MunicipalGraficoScreen> {
  DateTime _fechaSeleccionada = DateTime.now();

  String _formatearFecha(DateTime fecha) {
    return DateFormat('MM-yyyy').format(fecha); // para API
  }

  String _formatoVisible(DateTime fecha) {
    return DateFormat('MMMM, yyyy', 'es').format(fecha); // para mostrar
  }

  void _cambiarMes(int offset) {
    setState(() {
      _fechaSeleccionada = DateTime(
        _fechaSeleccionada.year,
        _fechaSeleccionada.month + offset,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mesParam = _formatearFecha(_fechaSeleccionada);
    final asyncData = ref.watch(graficoProvider(mesParam));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico de Reportes'),
        backgroundColor: Color(0xFF6B49F6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: asyncData.when(
          data: (datos) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _buildResumen('Basurales Reportados', datos.basural),
                  _buildResumen('Maltrato Animal', datos.maltratoAnimal),
                  _buildResumen('Microtráfico Confirmado', datos.microtrafico),
                  _buildResumen('Actividad ilícita', datos.actividadIlicita),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => _cambiarMes(-1),
                  ),
                  Text(_formatoVisible(_fechaSeleccionada), style: const TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => _cambiarMes(1),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(child: GraficoReportePieChart(data: datos)),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error al cargar gráfico: $e')),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color(0xFF6B49F6),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/municipal-reportes');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/reporte-mapa');
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sección Perfil no disponible aún')),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Registros'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _buildResumen(String titulo, int cantidad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(fontSize: 14)),
        Text('$cantidad Reportes', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}