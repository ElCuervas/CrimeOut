import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:frontend/features/auth/data/repositories/auth_repository_impl.dart';

final registerUserUseCaseProvider = Provider((ref) {
  final repository = ref.read(authRepositoryProvider);
  return RegisterUserUseCase(repository);
});

class RegisterUserUseCase {
  final AuthRepository repository;
  RegisterUserUseCase(this.repository);

  Future<void> execute({
    required String correo,
    required String password,
    required String nombre,
    required String rut,
  }) async {
    await repository.registerUser(
      correo: correo,
      password: password,
      nombre: nombre,
      rut: rut,
    );
  }
}
