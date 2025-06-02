import "package:frontend/features/reports/domain/repositories/reporte_repository.dart";
import "package:frontend/features/reports/domain/entities/reporte_request.dart";

/// Caso de uso encargado de crear un nuevo reporte.
///
/// Este caso de uso encapsula la lógica necesaria para enviar un reporte
/// al backend a través del repositorio correspondiente.
class CrearReporteUseCase {
  final ReporteRepository repository;

  /// Constructor que recibe una instancia del [ReporteRepository].
  CrearReporteUseCase(this.repository);

  /// Ejecuta la creación de un reporte.
  ///
  /// - [request]: objeto [ReporteRequest] con los datos del reporte.
  /// - [userId]: identificador del usuario que crea el reporte.
  ///
  /// Lanza una excepción si el backend responde con error.
  Future<void> call(ReporteRequest request, int userId) async {
    await repository.crearReporte(request, userId);
  }
}