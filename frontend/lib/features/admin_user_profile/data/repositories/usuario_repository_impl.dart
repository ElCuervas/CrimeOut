import 'package:dio/dio.dart';
import '../../domain/entities/usuario_perfil.dart';
import '../../domain/repositories/usuario_repository.dart';
import '../models/usuario_perfil_model.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final Dio dio;

  UsuarioRepositoryImpl(this.dio);

  @override
  Future<UsuarioPerfil> getUsuarioById(int id) async {
    try {
      final response = await dio.get('/api/v1/crimeout/usuario/buscar/$id');
      return UsuarioPerfilModel.fromJson(response.data);
    } on DioError catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al obtener usuario');
    }
  }

  @override
  Future<void> eliminarUsuario(int id) async {
    try {
      final response = await dio.delete('/api/v1/crimeout/user/$id');
      if (response.statusCode != 201) {
        throw Exception('No se pudo eliminar el usuario');
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al eliminar usuario');
    }
  }
}