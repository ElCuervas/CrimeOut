import '../repositories/usuario_repository.dart';

class DeleteUsuarioUseCase {
  final UsuarioRepository repository;

  DeleteUsuarioUseCase(this.repository);

  Future<void> execute(int idUsuario) {
    return repository.eliminarUsuario(idUsuario);
  }
}