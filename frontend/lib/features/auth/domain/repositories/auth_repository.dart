abstract class AuthRepository {
  Future<void> registerUser({
    required String correo,
    required String password,
    required String nombre,
    required String rut,
  });
}