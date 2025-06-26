import '../entities/estado_sistema.dart';
import '../repositories/admin_repository.dart';

class GetEstadoSistemaUseCase {
  final AdminRepository repository;

  GetEstadoSistemaUseCase(this.repository);

  Future<EstadoSistema> execute() {
    return repository.obtenerEstadoSistema();
  }
}