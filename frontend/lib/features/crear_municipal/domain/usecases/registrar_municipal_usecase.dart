import '../entities/registro_municipal.dart';
import '../repositories/registro_municipal_repository.dart';

class RegistrarMunicipalUseCase {
  final RegistroMunicipalRepository repository;

  RegistrarMunicipalUseCase(this.repository);

  Future<void> execute(RegistroMunicipal registro) async {
    await repository.registrarUsuarioMunicipal(registro);
  }
}