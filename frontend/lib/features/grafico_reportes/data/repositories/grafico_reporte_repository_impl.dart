import '../../domain/entities/grafico_reporte.dart';
import '../../domain/repositories/grafico_reporte_repository.dart';
import '../datasources/grafico_reporte_remote_data_source.dart';

class GraficoReporteRepositoryImpl implements GraficoReporteRepository {
  final GraficoReporteRemoteDataSource remoteDataSource;

  GraficoReporteRepositoryImpl(this.remoteDataSource);

  @override
  Future<GraficoReporte> obtenerDatosDelMes(String mes) {
    return remoteDataSource.fetchReportePorMes(mes);
  }
}