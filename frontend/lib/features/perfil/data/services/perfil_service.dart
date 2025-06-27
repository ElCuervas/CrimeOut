import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/usuario.dart';

class PerfilService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1/crimeout';
  static const storage = FlutterSecureStorage();

  static Future<Usuario> obtenerUsuario(int id) async {
    try {
      final token = await storage.read(key: 'jwt_token');
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/usuario/buscar/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Usuario.fromJson(data);
      } else if (response.statusCode == 404) {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Usuario no encontrado');
      } else {
        throw Exception('Error al obtener usuario: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  static Future<Usuario> obtenerUsuarioActual() async {
    try {
      final userIdString = await storage.read(key: 'user_id');
      if (userIdString == null) {
        throw Exception('No se encontró el ID del usuario en sessionStorage');
      }
      
      final userId = int.tryParse(userIdString);
      if (userId == null) {
        throw Exception('ID de usuario inválido en sessionStorage');
      }
      print('ID de usuario obtenido: $userId');
      return await obtenerUsuario(userId);
    } catch (e) {
      throw Exception('Error al obtener usuario actual: $e');
    }
  }
}
