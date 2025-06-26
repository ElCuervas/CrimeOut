import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/registro_municipal_model.dart';

class RegistroMunicipalRemoteDataSource {
  final Dio _dio = Dio();
  final _storage = const FlutterSecureStorage();
  final String _baseUrl = 'http://10.0.2.2:8080/api/v1/crimeout';

  Future<void> registrarUsuarioMunicipal(RegistroMunicipalModel model) async {
    final token = await _storage.read(key: 'jwt_token');

    try {
      final response = await _dio.post(
        '$_baseUrl/auth/admin/register',
        data: model.toJson(),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al crear usuario municipal');
      }
    } catch (e) {
      throw Exception('Error de red o del servidor: ${e.toString()}');
    }
  }
}