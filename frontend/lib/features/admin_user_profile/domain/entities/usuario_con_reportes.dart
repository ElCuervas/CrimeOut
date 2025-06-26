import '../../domain/entities/reporte_usuario.dart';
class UsuarioConReportes {
  final int idUsuario;
  final String nombreUsuario;
  final List<String> roles;
  final List<ReporteUsuario> reportes;

  UsuarioConReportes({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.roles,
    required this.reportes,
  });
}