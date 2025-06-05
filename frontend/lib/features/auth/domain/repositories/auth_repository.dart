import '../../data/models/auth_models.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequest request);
  Future<void> register(RegisterRequest request);
}