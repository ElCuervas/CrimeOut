import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/estado_sistema_model.dart';
import '../models/usuario_admin_model.dart';

class AdminRemoteDataSource {
  final Dio _dio = Dio();
  final _storage = const FlutterSecureStorage();
  final String _baseUrl = 'http://10.0.2.2:8080/api/v1/crimeout';

  /// 🔹 Obtener estado del sistema
  Future<EstadoSistemaModel> fetchEstadoSistema() async {
    final token = await _storage.read(key: 'jwt_token');
    final response = await _dio.get(
      '$_baseUrl/list/estado-sistema',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      return EstadoSistemaModel.fromJson(response.data);
    } else {
      throw Exception('Error al obtener estado del sistema');
    }
  }

  /// 🔹 Obtener usuarios por rol
  Future<List<UsuarioAdminModel>> fetchUsuariosPorRol(String rol) async {
    final token = await _storage.read(key: 'jwt_token');
    final response = await _dio.get(
      '$_baseUrl/list/usuarios-rol/$rol',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((u) => UsuarioAdminModel.fromJson(u)).toList();
    } else {
      throw Exception('Error al obtener usuarios por rol');
    }
  }

  /// 🔹 Obtener usuario por nombre
  Future<List<UsuarioAdminModel>> fetchUsuarioPorNombre(String nombre) async {
  final token = await _storage.read(key: 'jwt_token');
  final response = await _dio.get(
    '$_baseUrl/list/usuarios-nombre/$nombre',
    options: Options(headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    }),
  );

  if (response.statusCode == 200) {
    final List data = response.data;
    return data.map((e) => UsuarioAdminModel.fromJson(e)).toList();
  } else {
    throw Exception('Usuario no encontrado');
  }
}
}