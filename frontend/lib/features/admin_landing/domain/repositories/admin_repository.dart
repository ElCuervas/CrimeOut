import '../entities/estado_sistema.dart';
import '../entities/usuario_admin.dart';

abstract class AdminRepository {
  /// Obtener datos del estado general del sistema
  Future<EstadoSistema> obtenerEstadoSistema();

  /// Obtener lista de usuarios por rol (municipal o común)
  Future<List<UsuarioAdmin>> obtenerUsuariosPorRol(String rol);

  /// Obtener un usuario por nombre
  Future<List<UsuarioAdmin>> getUsuarioPorNombre(String nombre);
}