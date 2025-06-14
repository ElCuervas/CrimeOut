import '../entities/grafico_reporte.dart';
import '../repositories/grafico_reporte_repository.dart';

class GetGraficoReporteUseCase {
  final GraficoReporteRepository repository;

  GetGraficoReporteUseCase(this.repository);

  Future<GraficoReporte> execute(String mes) {
    return repository.obtenerDatosDelMes(mes);
  }
}