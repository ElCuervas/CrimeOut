import '../entities/reporte_sospechoso.dart';

abstract class ReporteSospechosoRepository {
  Future<List<ReporteSospechoso>> obtenerReportesSospechosos();
}