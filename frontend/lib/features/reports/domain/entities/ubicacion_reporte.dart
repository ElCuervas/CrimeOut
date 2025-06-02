class UbicacionReporte {
  final String tipoReporte;
  final List<double> ubicacion;
  final DateTime fecha;
  final String imagen;
  final String detalles;
  final bool confiable;
  final bool solucionado;

  UbicacionReporte({
    required this.tipoReporte,
    required this.ubicacion,
    required this.fecha,
    required this.imagen,
    required this.detalles,
    required this.confiable,
    required this.solucionado,
  });

  factory UbicacionReporte.fromJson(Map<String, dynamic> json) {
    return UbicacionReporte(
      tipoReporte: json['tipoReporte'],
      ubicacion: List<double>.from(json['ubicacion']),
      fecha: DateTime.parse(json['fecha']),
      imagen: json['imagen'],
      detalles: json['detalles'],
      confiable: json['confiable'],
      solucionado: json['solucionado'],
    );
  }
}