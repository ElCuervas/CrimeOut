import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/auth_models.dart';

// Provider para inyectar donde quieras
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class AuthService {
  // En Android emulator: 10.0.2.2; iOS Sim: localhost; físico: IP máquina
  static const _baseUrl = 'http://10.0.2.2:8080/api/v1/crimeout';
  final _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    headers: {'Content-Type': 'application/json'},
  ));
  final _storage = const FlutterSecureStorage();

  Future<LoginResponse> login(LoginRequest req) async {
    try {
      final resp = await _dio.post(
        '/auth/login',
        data: jsonEncode(req.toJson()),
      );

      final body = resp.data as Map<String, dynamic>;
      final loginResp = LoginResponse.fromJson(body);
      await _storage.write(key: 'jwt_token', value: loginResp.token);
      return loginResp;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        final msg = (e.response?.data as Map<String, dynamic>)['message'];
        throw Exception(msg ?? 'Usuario o contraseña incorrectos');
      }
      throw Exception('Error ${e.response?.statusCode}: ${e.message}');
    }
  }
}