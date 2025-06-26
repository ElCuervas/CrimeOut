import '../entities/reporte_usuario.dart';

abstract class UsuarioReportesRepository {
  Future<ReporteUsuario> getReportesDeUsuario(int idUsuario);
}