import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/reporte_providers.dart';

class SeleccionarReporteScreen extends ConsumerWidget {
  const SeleccionarReporteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String modo = ModalRoute.of(context)!.settings.arguments as String;
    void seleccionarTipo(String tipo) {
      ref.read(tipoReporteSeleccionadoProvider.notifier).state = tipo;
      Navigator.pushNamed(context, '/seleccionar-ubicacion', arguments: modo);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona el tipo de reporte'),
        centerTitle: true,
        backgroundColor: const Color(0xFF6B49F6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
          children: [
            _TipoReporteBoton(
              color: Colors.orange,
              icon: Icons.warning,
              label: 'Actividad Ilícita',
              onTap: () => seleccionarTipo('ACTIVIDAD_ILICITA'),
            ),
            _TipoReporteBoton(
              color: Colors.red,
              icon: Icons.medication,
              label: 'Microtráfico',
              onTap: () => seleccionarTipo('MICROTRAFICO'),
            ),
            _TipoReporteBoton(
              color: Colors.green,
              icon: Icons.pets,
              label: 'Maltrato Animal',
              onTap: () => seleccionarTipo('MALTRATO_ANIMAL'),
            ),
            _TipoReporteBoton(
              color: Colors.brown,
              icon: Icons.delete,
              label: 'Basural',
              onTap: () => seleccionarTipo('BASURAL'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Reportar'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        onTap: (index) {
          // Aquí puedes manejar navegación futura
        },
      ),
    );
  }
}

class _TipoReporteBoton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _TipoReporteBoton({
    required this.color,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 48),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}