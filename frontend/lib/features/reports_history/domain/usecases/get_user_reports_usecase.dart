import '../entities/report_history.dart';
import '../repositories/report_history_repository.dart';

class GetUserReportsUseCase {
  final ReportHistoryRepository repository;

  GetUserReportsUseCase(this.repository);

  Future<ReporteUsuario> execute(int userId) async {
    return repository.getReports(userId);
  }
}