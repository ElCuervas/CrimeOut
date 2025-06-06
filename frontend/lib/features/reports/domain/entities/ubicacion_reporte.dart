/// Modelo que representa un reporte con ubicación geográfica para visualizar en el mapa.
///
/// Contiene información del tipo de reporte, coordenadas, fecha de creación,
/// imagen asociada, detalles, y su estado (confiable o solucionado).
class UbicacionReporte {
  /// Tipo del reporte (ej: 'BASURAL', 'ACTIVIDAD_ILICITA', etc.).
  final String tipoReporte;

  /// Lista con dos valores: [latitud, longitud] de la ubicación.
  final List<double> ubicacion;

  /// Fecha en que se generó el reporte.
 

  /// Imagen asociada al reporte (puede ser URL o base64).


  /// Detalles descriptivos proporcionados por el usuario.
  final String detalles;

  /// Indica si el reporte fue validado como confiable.
  

  /// Indica si el incidente reportado ya ha sido solucionado.


  /// Constructor para inicializar una instancia de [UbicacionReporte].
  UbicacionReporte({
    required this.tipoReporte,
    required this.ubicacion,
    required this.detalles,
  });

  /// Crea una instancia de [UbicacionReporte] a partir de un mapa JSON.
  ///
  /// - El campo `ubicacion` se espera como una lista `[latitud, longitud]`.
  /// - El campo `fecha` debe estar en formato ISO 8601 (`YYYY-MM-DDTHH:MM:SS`).
  factory UbicacionReporte.fromJson(Map<String, dynamic> json) {
    return UbicacionReporte(
      tipoReporte: json['tipoReporte'],
      ubicacion: List<double>.from(json['ubicacion']),
      detalles: json['detalles'],
    );
  }
}