/// Modelo que representa una solicitud para crear un nuevo reporte.
///
/// Contiene información relacionada con el usuario, tipo de reporte,
/// ubicación geográfica, detalles adicionales, imagen en base64.
class ReporteRequest {

  /// Tipo de reporte (por ejemplo, 'BASURAL', 'MICROTRAFICO', etc.).
  final String tipoReporte;

  /// Latitud de la ubicación del reporte.
  final double latitud;

  /// Longitud de la ubicación del reporte.
  final double longitud;

  /// Imagen asociada al reporte codificada en base64.
  final String imagen;

  /// Detalles adicionales descriptivos del reporte.
  final String detalles;

  /// Constructor que inicializa todos los campos obligatorios del reporte.
  ///
  /// Los campos [confiable] y [solucionado] son opcionales y se inicializan como `false` por defecto.
  ReporteRequest({
    required this.tipoReporte,
    required this.latitud,
    required this.longitud,
    required this.imagen,
    required this.detalles
  });

  /// Convierte la instancia en un mapa JSON para ser enviado al backend.
  ///
  /// - El campo `ubicacion` se representa como una lista `[latitud, longitud]`.
  Map<String, dynamic> toJson() => {
        "tipoReporte": tipoReporte,
        "ubicacion": [latitud, longitud],
        "imagen": imagen,
        "detalles": detalles
      };
}