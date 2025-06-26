import '../entities/usuario_perfil.dart';

abstract class UsuarioRepository {
  Future<UsuarioPerfil> getUsuarioById(int id);
  Future<void> eliminarUsuario(int id);
}