class ReporteSospechoso {
  final int idUsuario;
  final String tipoReporte;
  final String imagenUrl;
  final String detalles;

  ReporteSospechoso({
    required this.idUsuario,
    required this.tipoReporte,
    required this.imagenUrl,
    required this.detalles,
  });
}