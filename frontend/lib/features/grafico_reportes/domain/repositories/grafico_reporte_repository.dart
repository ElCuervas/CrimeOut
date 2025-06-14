import '../entities/grafico_reporte.dart';

abstract class GraficoReporteRepository {
  Future<GraficoReporte> obtenerDatosDelMes(String mes);
}