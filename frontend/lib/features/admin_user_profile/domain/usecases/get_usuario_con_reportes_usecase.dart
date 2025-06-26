import 'package:frontend/features/admin_user_profile/domain/repositories/usuario_con_reportes_repository.dart';
import '../../domain/entities/usuario_con_reportes.dart';

class GetUsuarioConReportesUseCase {
  final UsuarioConReportesRepository repository;

  GetUsuarioConReportesUseCase(this.repository);

  Future<UsuarioConReportes> execute(int id) => repository.fetchUsuarioConReportes(id);
}

class DeleteUsuarioUseCase {
  final UsuarioConReportesRepository repository;

  DeleteUsuarioUseCase(this.repository);

  Future<void> execute(int id) => repository.eliminarUsuario(id);
}