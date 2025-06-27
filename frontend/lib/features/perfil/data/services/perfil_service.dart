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

  static Future<void> enviarSugerencia(String mensaje) async {
    try {
      final token = await storage.read(key: 'jwt_token');
      final userIdString = await storage.read(key: 'user_id');
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }
      
      if (userIdString == null) {
        throw Exception('No se encontró el ID del usuario');
      }
      
      final userId = int.tryParse(userIdString);
      if (userId == null) {
        throw Exception('ID de usuario inválido');
      }

      final requestBody = {
        'idUsuario': userId,
        'mensaje': mensaje,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/sugerencia'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('Response Headers: ${response.headers}');

      if (response.statusCode == 200) {
        // Verificar si la respuesta tiene contenido antes de decodificar
        if (response.body.isNotEmpty) {
          try {
            final data = json.decode(response.body);
            print('Parsed JSON: $data');
          } catch (e) {
            print('Error parsing JSON: $e');
            // Si no se puede parsear como JSON pero el status es 200, considerarlo exitoso
          }
        }
        // Sugerencia enviada exitosamente
        return;
      } else if (response.statusCode == 400) {
        try {
          final errorData = json.decode(response.body);
          throw Exception(errorData['message'] ?? 'Error al crear sugerencia');
        } catch (e) {
          throw Exception('Error al crear sugerencia - Status: ${response.statusCode}');
        }
      } else {
        throw Exception('Error al enviar sugerencia: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  static Future<void> actualizarUsuario({
    required int userId,
    required String nombre,
    required String correo,
    required String contrasena,
  }) async {
    try {
      final token = await storage.read(key: 'jwt_token');
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final requestBody = {
        'correo': correo,
        'nombre': nombre,
        'contrasena': contrasena,
      };

      final response = await http.patch(
        Uri.parse('$baseUrl/usuario/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('Response Headers: ${response.headers}');

      if (response.statusCode == 200) {
        // Usuario actualizado exitosamente
        if (response.body.isNotEmpty) {
          try {
            final data = json.decode(response.body);
            print('Parsed JSON: $data');
          } catch (e) {
            print('Error parsing JSON: $e');
            // Si no se puede parsear como JSON pero el status es 200, considerarlo exitoso
          }
        }
        return;
      } else if (response.statusCode == 404) {
        try {
          final errorData = json.decode(response.body);
          throw Exception(errorData['message'] ?? 'Usuario no encontrado');
        } catch (e) {
          throw Exception('Usuario no encontrado');
        }
      } else {
        throw Exception('Error al actualizar usuario: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  static Future<void> eliminarUsuario(int userId) async {
    try {
      final token = await storage.read(key: 'jwt_token');
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/user/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        // Usuario eliminado exitosamente
        if (response.body.isNotEmpty) {
          try {
            final data = json.decode(response.body);
            print('Usuario eliminado: ${data['message']}');
          } catch (e) {
            print('Error parsing JSON: $e');
            // Si no se puede parsear como JSON pero el status es 201, considerarlo exitoso
          }
        }
        return;
      } else if (response.statusCode == 404) {
        try {
          final errorData = json.decode(response.body);
          throw Exception(errorData['message'] ?? 'Usuario no encontrado');
        } catch (e) {
          throw Exception('Usuario no encontrado');
        }
      } else {
        throw Exception('Error al eliminar usuario: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
