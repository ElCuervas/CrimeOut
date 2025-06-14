import '../repositories/municipal_report_repository.dart';

class UpdateReporteEstadoUseCase {
  final MunicipalReportRepository repository;

  UpdateReporteEstadoUseCase(this.repository);

  Future<void> execute({
    required int id,
    required bool confiable,
    required bool solucionado,
  }) {
    return repository.actualizarEstadoReporte(
      id: id,
      confiable: confiable,
      solucionado: solucionado,
    );
  }
}