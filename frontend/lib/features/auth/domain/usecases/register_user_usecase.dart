import '../../data/models/auth_models.dart';
import '../repositories/auth_repository.dart';


class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<void> execute(RegisterRequest request) {
    return repository.register(request);
  }
}