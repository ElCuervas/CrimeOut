import "package:frontend/features/reports/domain/entities/reporte_request.dart";
import "package:frontend/features/reports/domain/entities/ubicacion_reporte.dart";


abstract class ReporteRepository {
  Future<void> crearReporte(ReporteRequest request, int userId);
  Future<List<UbicacionReporte>> obtenerReportesMapa();
}