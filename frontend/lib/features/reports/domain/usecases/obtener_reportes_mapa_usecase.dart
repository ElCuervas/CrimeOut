import '../repositories/reporte_repository.dart';
import '../entities/ubicacion_reporte.dart';

class ObtenerReportesMapaUseCase {
  final ReporteRepository repository;

  ObtenerReportesMapaUseCase(this.repository);

  Future<List<UbicacionReporte>> call() {
    return repository.obtenerReportesMapa();
  }
}