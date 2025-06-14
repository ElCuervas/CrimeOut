import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/municipal_report_provider.dart';
import '../widgets/municipal_reporte_card.dart';

class MunicipalListaReportesScreen extends ConsumerWidget {
  const MunicipalListaReportesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tipo = ModalRoute.of(context)!.settings.arguments as String;
    final reportesAsync = ref.watch(municipalReportProvider(tipo));

    return Scaffold(
      appBar: AppBar(
        title: Text('Registros $tipo'),
        backgroundColor: const Color(0xFF6B49F6),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb),
            onPressed: () {
              // Puedes agregar acción aquí
            },
          ),
        ],
      ),
      body: reportesAsync.when(
        data: (reportes) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: reportes.length,
          itemBuilder: (context, index) {
            final reporte = reportes[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MunicipalReporteCard(
                reporte: reporte,
                onUpdateEstado: (bool confiable, bool solucionado) async {
                  final usecase = ref.read(updateReporteEstadoUseCaseProvider);

                  try {
                    await usecase.execute(
                      id: reporte.idReporte, // ← este campo debe existir en tu entidad
                      confiable: confiable,
                      solucionado: solucionado,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('✅ Estado actualizado correctamente')),
                    );
                    // 🔄 Recargar lista
                    ref.invalidate(municipalReportProvider(tipo));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('❌ Error al actualizar: $e')),
                    );
                  }
                },
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error al cargar reportes: $e')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF6B49F6),
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
}