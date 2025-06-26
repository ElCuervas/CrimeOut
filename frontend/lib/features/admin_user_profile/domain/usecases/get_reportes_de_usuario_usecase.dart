import '../entities/reporte_usuario.dart';
import '../repositories/usuario_reportes_repository.dart';

class GetReportesDeUsuarioUseCase {
  final UsuarioReportesRepository repository;

  GetReportesDeUsuarioUseCase(this.repository);

  Future<ReporteUsuario> execute(int idUsuario) {
    return repository.getReportesDeUsuario(idUsuario);
  }
}