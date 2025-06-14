import '../entities/municipal_report.dart';

abstract class MunicipalReportRepository {
  Future<List<ReporteMunicipal>> obtenerReportesPorTipo(String tipoReporte);
  Future<void> actualizarEstadoReporte({
    required int id,
    required bool confiable,
    required bool solucionado,
  });
}