import '../entities/usuario_perfil.dart';
import '../repositories/usuario_repository.dart';

class GetUsuarioByIdUseCase {
  final UsuarioRepository repository;

  GetUsuarioByIdUseCase(this.repository);

  Future<UsuarioPerfil> execute(int idUsuario) {
    return repository.getUsuarioById(idUsuario);
  }
}