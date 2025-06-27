import '../entities/usuario_admin.dart';
import '../repositories/admin_repository.dart';

class GetUsuarioPorNombreUseCase {
  final AdminRepository repository;

  GetUsuarioPorNombreUseCase(this.repository);

  Future<List<UsuarioAdmin>> execute(String nombre) {
    return repository.getUsuarioPorNombre(nombre);
  }
}