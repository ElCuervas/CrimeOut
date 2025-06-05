import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_models.dart';


class AuthService implements AuthRepository {
  static const _baseUrl = 'http://10.0.2.2:8080/api/v1/crimeout';

  final _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    headers: {'Content-Type': 'application/json'},
  ));
  final _storage = const FlutterSecureStorage();

  @override
  Future<LoginResponse> login(LoginRequest req) async {
    final resp = await _dio.post('/auth/login', data: jsonEncode(req.toJson()));
    final body = resp.data as Map<String, dynamic>;
    final loginResp = LoginResponse.fromJson(body);

    await _storage.write(key: 'jwt_token', value: loginResp.token);
    await _storage.write(key: 'user_id', value: loginResp.idUsuario.toString());

    return loginResp;
  }

  @override
  Future<void> register(RegisterRequest request) async {
    try {
      await _dio.post('/auth/register', data: jsonEncode(request.toJson()));
    } on DioException catch (e) {
      throw Exception('Registro fallido: ${e.response?.data['message'] ?? e.message}');
    }
  }
  Future<String?> getToken() async {
  return await _storage.read(key: 'jwt_token');
}
}