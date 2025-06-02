
class ReporteRequest {
  final int idUsuario;
  final String tipoReporte;
  final double latitud;
  final double longitud;
  final String imagen;
  final String detalles;
  final String fecha;
  final bool confiable;
  final bool solucionado;

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

  Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "tipoReporte": tipoReporte,
        "ubicacion": [latitud,longitud],
        "fecha": fecha,
        "imagen": imagen,
        "detalles": detalles,
        "confiable": confiable,
        "solucionado": solucionado,
      };
}