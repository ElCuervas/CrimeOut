import "package:frontend/features/reports/domain/repositories/reporte_repository.dart";
import "package:frontend/features/reports/domain/entities/reporte_request.dart";

class CrearReporteUseCase {
  final ReporteRepository repository;

  CrearReporteUseCase(this.repository);

  Future<void> call(ReporteRequest request, int userId) {
    return repository.crearReporte(request, userId);
  }
}