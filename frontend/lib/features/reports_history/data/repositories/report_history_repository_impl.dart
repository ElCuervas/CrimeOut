import '../../domain/entities/report_history.dart';
import '../../domain/repositories/report_history_repository.dart';
import '../datasources/report_history_remote_data_source.dart';

class ReportHistoryRepositoryImpl implements ReportHistoryRepository {
  final ReportHistoryRemoteDataSource remoteDataSource;

  ReportHistoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<ReporteUsuario> getReports(int userId) async {
    final model = await remoteDataSource.getReportsByUserId(userId);
    return ReporteUsuario(
      idUsuario: model.idUsuario,
      nombreUsuario: model.nombreUsuario,
      roles: model.roles,
      reportes: model.reportes.map((e) => Reporte(
        tipoReporte: e.tipoReporte,
        detalles: e.detalles,
        fecha: e.fecha,
        imagen: e.imagen,
        ubicacion: e.ubicacion,
        confiable: e.confiable,
        solucionado: e.solucionado,
      )).toList(),
    );
  }
}