import 'package:frontend/features/admin_reportes/domain/entities/reporte_sospechoso.dart';
import 'package:frontend/features/admin_reportes/domain/repositories/reporte_sospechoso_repository.dart';

class GetReportesSospechososUseCase {
  final ReporteSospechosoRepository repository;

  GetReportesSospechososUseCase(this.repository);

  Future<List<ReporteSospechoso>> execute() {
    return repository.obtenerReportesSospechosos();
  }
}