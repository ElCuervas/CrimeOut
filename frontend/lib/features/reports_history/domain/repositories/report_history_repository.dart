import '../entities/report_history.dart';

abstract class ReportHistoryRepository {
  Future<ReporteUsuario> getReports(int userId);
}