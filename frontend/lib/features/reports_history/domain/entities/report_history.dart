class ReporteUsuario {
  final int idUsuario;
  final String nombreUsuario;
  final String roles;
  final List<Reporte> reportes;

  ReporteUsuario({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.roles,
    required this.reportes,
  });
}

class Reporte {
  final String tipoReporte;
  final String detalles;
  final String fecha;
  final String imagen;
  final List<double> ubicacion;
  final bool confiable;
  final bool solucionado;

  Reporte({
    required this.tipoReporte,
    required this.detalles,
    required this.fecha,
    required this.imagen,
    required this.ubicacion,
    required this.confiable,
    required this.solucionado,
  });
}