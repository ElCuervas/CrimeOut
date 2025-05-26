import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/auth/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

class AuthRepositoryImpl implements AuthRepository {
  final String _baseUrl = 'http://10.0.2.2:8080/api/v1/crimeout/auth'; // Ajustar según entorno

  @override
  Future<void> registerUser({
    required String correo,
    required String password,
    required String nombre,
    required String rut,
  }) async {
    final url = Uri.parse('$_baseUrl/register');
    final body = jsonEncode({
      'correo': correo,
      'password': password,
      'nombre': nombre,
      'rut': rut,
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Error al registrar usuario: ${response.body}');
    }
  }
}
