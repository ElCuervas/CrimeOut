/// Modelo que representa una solicitud para crear un nuevo reporte.
///
/// Contiene información relacionada con el usuario, tipo de reporte,
/// ubicación geográfica, detalles adicionales, imagen en base64, y estado.
class ReporteRequest {
  /// Identificador del usuario que crea el reporte.
  final int idUsuario;

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

  /// Fecha en la que se genera el reporte, en formato ISO 8601 (`YYYY-MM-DDTHH:MM:SS`).
  final String fecha;

  /// Indica si el reporte ha sido considerado confiable (por defecto: false).
  final bool confiable;

  /// Indica si el reporte ya fue solucionado (por defecto: false).
  final bool solucionado;

  /// Constructor que inicializa todos los campos obligatorios del reporte.
  ///
  /// Los campos [confiable] y [solucionado] son opcionales y se inicializan como `false` por defecto.
  ReporteRequest({
    required this.idUsuario,
    required this.tipoReporte,
    required this.latitud,
    required this.longitud,
    required this.imagen,
    required this.detalles,
    required this.fecha,
    this.confiable = false,
    this.solucionado = false,
  });

  /// Convierte la instancia en un mapa JSON para ser enviado al backend.
  ///
  /// - El campo `ubicacion` se representa como una lista `[latitud, longitud]`.
  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "tipoReporte": tipoReporte,
        "ubicacion": [latitud, longitud],
        "fecha": fecha,
        "imagen": imagen,
        "detalles": detalles,
        "confiable": confiable,
        "solucionado": solucionado,
      };
}