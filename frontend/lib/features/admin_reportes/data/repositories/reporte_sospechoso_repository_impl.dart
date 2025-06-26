
import 'package:frontend/features/admin_reportes/data/datasources/reporte_sospechoso_remote_data_source.dart';
import 'package:frontend/features/admin_reportes/domain/entities/reporte_sospechoso.dart';
import 'package:frontend/features/admin_reportes/domain/repositories/reporte_sospechoso_repository.dart';

class ReporteSospechosoRepositoryImpl implements ReporteSospechosoRepository {
  final ReporteSospechosoRemoteDataSource remoteDataSource;

  ReporteSospechosoRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ReporteSospechoso>> obtenerReportesSospechosos() {
    return remoteDataSource.fetchReportesSospechosos();
  }
}