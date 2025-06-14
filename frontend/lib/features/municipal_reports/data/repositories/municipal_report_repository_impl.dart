import '../../domain/entities/municipal_report.dart';
import '../../domain/repositories/municipal_report_repository.dart';
import '../datasources/municipal_report_remote_data_source.dart';

class MunicipalReportRepositoryImpl implements MunicipalReportRepository {
  final ReporteMunicipalRemoteDataSource remoteDataSource;

  MunicipalReportRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ReporteMunicipal>> obtenerReportesPorTipo(String tipoReporte) {
    return remoteDataSource.fetchReportesPorTipo(tipoReporte);
  }
  @override
  Future<void> actualizarEstadoReporte({
    required int id,
    required bool confiable,
    required bool solucionado,
  }) {
    return remoteDataSource.actualizarEstadoReporte(
      id: id,
      confiable: confiable,
      solucionado: solucionado,
    );
  }
}