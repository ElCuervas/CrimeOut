import 'package:dio/dio.dart';
import '../../domain/entities/usuario_con_reportes.dart';
import '../../domain/repositories/usuario_con_reportes_repository.dart';
import '../models/usuario_con_reportes_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UsuarioConReportesRepositoryImpl implements UsuarioConReportesRepository {
  final dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8080'));
   final _storage = const FlutterSecureStorage();

  UsuarioConReportesRepositoryImpl();

  @override
  Future<UsuarioConReportes> fetchUsuarioConReportes(int id) async {
    try {
      final token = await _storage.read(key: 'jwt_token');
      final res = await dio.get('/api/v1/crimeout/user/$id/reportes',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }),);
      print("📦 Response data: ${res.data}"); 
      return UsuarioConReportesModel.fromJson(res.data);
    } on DioError catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al cargar usuario');
    }
  }

  @override
  Future<void> eliminarUsuario(int id) async {
    try {
      final res = await dio.delete('/api/v1/crimeout/user/$id');
      if (res.statusCode != 201) {
        throw Exception('No se pudo eliminar el usuario');
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error al eliminar usuario');
    }
  }
}