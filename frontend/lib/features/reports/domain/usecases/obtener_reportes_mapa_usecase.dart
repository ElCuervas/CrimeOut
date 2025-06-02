import '../repositories/reporte_repository.dart';
import '../entities/ubicacion_reporte.dart';

/// Caso de uso encargado de obtener los reportes geolocalizados para el mapa.
///
/// Utiliza el [ReporteRepository] para solicitar al backend todos los
/// reportes disponibles, incluyendo tipo, ubicación, estado y detalles.
class ObtenerReportesMapaUseCase {
  final ReporteRepository repository;

  /// Constructor que recibe el repositorio [ReporteRepository] para acceder a los datos.
  ObtenerReportesMapaUseCase(this.repository);

  /// Ejecuta la operación para obtener la lista de reportes con ubicación.
  ///
  /// Retorna una [List] de [UbicacionReporte] si la operación es exitosa.
  /// Lanza una excepción si ocurre un error al comunicarse con el backend.
  Future<List<UbicacionReporte>> call() {
    return repository.obtenerReportesMapa();
  }
}