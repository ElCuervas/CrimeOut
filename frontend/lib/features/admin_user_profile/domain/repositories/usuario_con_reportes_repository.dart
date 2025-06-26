import '../entities/usuario_con_reportes.dart';

abstract class UsuarioConReportesRepository {
  Future<UsuarioConReportes> fetchUsuarioConReportes(int id);
  Future<void> eliminarUsuario(int id);
}