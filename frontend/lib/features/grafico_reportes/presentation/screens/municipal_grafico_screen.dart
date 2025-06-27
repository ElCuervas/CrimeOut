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
        title: const Text(
          'Gráfico de Reportes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF6B49F6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: asyncData.when(
          data: (datos) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildResumen('Basurales', datos.basural, Color(0xFFC3831D)),
                            const SizedBox(height: 24),
                            _buildResumen('Microtráfico', datos.microtrafico, Color(0xFFE14433)),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        color: const Color(0xFFDDDDDD), // línea divisoria gris clara
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildResumen('Maltrato Animal', datos.maltratoAnimal, Color(0xFF867DFF)),
                            const SizedBox(height: 24),
                            _buildResumen('Actividad ilícita', datos.actividadIlicita, Color(0xFFE1CF47)),
                          ],
                        ),
                      ),
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

  Widget _buildResumen(String titulo, int cantidad, Color color) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.45,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          NumberFormat.decimalPattern('es').format(cantidad),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xFF2E2E2E),
          ),
        ),
        const Text(
          'Reportes',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6F6F6F),
          ),
        ),
      ],
    ),
  );
}
}