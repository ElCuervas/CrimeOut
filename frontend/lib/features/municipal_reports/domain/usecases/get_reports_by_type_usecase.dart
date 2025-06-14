import '../entities/municipal_report.dart';
import '../repositories/municipal_report_repository.dart';

class GetReportsByTypeUseCase {
  final MunicipalReportRepository repository;

  GetReportsByTypeUseCase(this.repository);

  Future<List<ReporteMunicipal>> execute(String tipoReporte) {
    return repository.obtenerReportesPorTipo(tipoReporte);
  }
}