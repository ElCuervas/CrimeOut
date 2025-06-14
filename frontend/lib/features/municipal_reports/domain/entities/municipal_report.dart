class ReporteMunicipal {
  final int idReporte;
  final String tipoReporte;
  final String ubicacion;
  final DateTime fecha;
  final String imagenUrl;
  final String detalles;
  final bool confiable;
  final bool solucionado;

  ReporteMunicipal({
    required this.idReporte,
    required this.tipoReporte,
    required this.ubicacion,
    required this.fecha,
    required this.imagenUrl,
    required this.detalles,
    required this.confiable,
    required this.solucionado,
  });
}