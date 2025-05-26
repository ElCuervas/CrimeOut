abstract class AuthRepository {
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String rut,
  });
}