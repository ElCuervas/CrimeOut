import "package:frontend/features/reports/domain/entities/reporte_request.dart";
import "package:frontend/features/reports/domain/entities/ubicacion_reporte.dart";

/// Contrato de repositorio para manejar operaciones relacionadas a reportes.
///
/// Esta interfaz define los métodos necesarios para enviar y obtener reportes
/// dentro del sistema, sirviendo como puente entre la capa de dominio y la capa de datos.
abstract class ReporteRepository {
  /// Crea un nuevo reporte asociado a un usuario.
  ///
  /// - [request]: Objeto con los datos del reporte.
  /// - [userId]: ID del usuario que envía el reporte.
  ///
  /// Lanza una excepción si ocurre un error durante el envío.
  Future<void> crearReporte(ReporteRequest request, int userId);

  /// Obtiene una lista de reportes existentes con información de ubicación.
  ///
  /// Este método puede ser utilizado para representar los reportes en un mapa.
  ///
  /// Retorna una lista de objetos [UbicacionReporte].
  /// Lanza una excepción si falla la solicitud al backend.
  Future<List<UbicacionReporte>> obtenerReportesMapa();
}