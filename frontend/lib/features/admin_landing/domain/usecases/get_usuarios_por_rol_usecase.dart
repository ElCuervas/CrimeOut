import '../entities/usuario_admin.dart';
import '../repositories/admin_repository.dart';

class GetUsuariosPorRolUseCase {
  final AdminRepository repository;

  GetUsuariosPorRolUseCase(this.repository);

  Future<List<UsuarioAdmin>> execute(String rol) {
    return repository.obtenerUsuariosPorRol(rol);
  }
}

