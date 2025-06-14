import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/reporte_historial_item.dart';
import '../providers/report_history_provider.dart';
import 'package:frontend/core/utils/iconos_reportes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class HistorialReportesScreen extends ConsumerStatefulWidget {
  const HistorialReportesScreen({super.key});

  @override
  ConsumerState<HistorialReportesScreen> createState() => _HistorialReportesScreenState();
}

class _HistorialReportesScreenState extends ConsumerState<HistorialReportesScreen> {
  Map<String, ImageProvider> _iconos = {};

  @override
  void initState() {
    super.initState();
    verificarContenidoToken();
    _cargarIconos();

    Future.microtask(() {
    ref.invalidate(reportHistoryProvider);
  });
  }

 Future<void> _cargarIconos() async {
  final iconosMap = await IconosReportes.cargarIconosUI(); // <-- usamos los AssetImage
  setState(() {
    _iconos = iconosMap;
  });
}

  @override
  Widget build(BuildContext context) {
    final asyncReportes = ref.watch(reportHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Reportes'),
        backgroundColor: const Color(0xFF6B49F6),
      ),
      body: asyncReportes.when(
        data: (reportes) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: reportes.reportes.length,
          itemBuilder: (context, index) {
          final reporte = reportes.reportes[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ReporteHistorialItem(
                tipo: reporte.tipoReporte,
                descripcion: reporte.detalles,
                icono: _iconos[reporte.tipoReporte],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error al cargar historial: $e')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Color(0xFF6B49F6),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/reporte-mapa');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/historial-reportes');
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sección Perfil no disponible aún')),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.place), label: "Reportar"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Historial"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      )
    );
  }
  void verificarContenidoToken() async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'jwt_token');

  if (token == null) {
    print('❌ No hay token almacenado');
    return;
  }

  final decoded = JwtDecoder.decode(token);
  print('✅ Payload del token: $decoded');

  if (decoded.containsKey('id')) {
    print('✅ El token contiene el campo "id": ${decoded['id']}');
  } else {
    print('❌ El token NO contiene el campo "id"');
  }
}
}