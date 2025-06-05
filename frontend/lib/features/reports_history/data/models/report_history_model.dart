class ReporteUsuarioModel {
  final int idUsuario;
  final String nombreUsuario;
  final String roles;
  final List<ReporteModel> reportes;

  ReporteUsuarioModel({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.roles,
    required this.reportes,
  });

  factory ReporteUsuarioModel.fromJson(Map<String, dynamic> json) {
    return ReporteUsuarioModel(
      idUsuario: json['idUsuario'],
      nombreUsuario: json['nombreUsuario'],
      roles: json['roles'],
      reportes: List<ReporteModel>.from(
        json['reportes'].map((r) => ReporteModel.fromJson(r)),
      ),
    );
  }
}

class ReporteModel {
  final String tipoReporte;
  final String detalles;
  final String fecha;
  final List<double> ubicacion;
  final String imagen;
  final bool confiable;
  final bool solucionado;

  ReporteModel({
    required this.tipoReporte,
    required this.detalles,
    required this.fecha,
    required this.ubicacion,
    required this.imagen,
    required this.confiable,
    required this.solucionado,
  });

  factory ReporteModel.fromJson(Map<String, dynamic> json) {
    return ReporteModel(
      tipoReporte: json['tipoReporte'],
      detalles: json['detalles'],
      fecha: json['fecha'],
      ubicacion: List<double>.from(json['ubicacion']),
      imagen: json['imagen'] ?? '',
      confiable: json['confiable'] ?? false,
      solucionado: json['solucionado'] ?? false,
    );
  }
}