import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtUtils {
  static const _storage = FlutterSecureStorage();

  static Future<Map<String, dynamic>> _decodeToken() async {
    final token = await _storage.read(key: 'jwt_token');
    if (token == null) throw Exception('No token found');
    return JwtDecoder.decode(token);
  }

  static Future<String> getRol() async {
    final decoded = await _decodeToken();
    return decoded['rol'] ?? 'usuario';
  }

  static Future<String> getNombre() async {
    final decoded = await _decodeToken();
    return decoded['nombre'] ?? '';
  }

  static Future<String> getRut() async {
    final decoded = await _decodeToken();
    return decoded['rut'] ?? '';
  }

  static Future<int> getId() async {
    final decoded = await _decodeToken();
    return int.tryParse(decoded['id'].toString()) ?? -1;
  }

  static Future<List<dynamic>> getReportes() async {
    final decoded = await _decodeToken();
    return decoded['reportes'] ?? [];
  }

  static Future<bool> isTokenExpired() async {
    final token = await _storage.read(key: 'jwt_token');
    return token == null || JwtDecoder.isExpired(token);
  }

  static Future<bool> getKeepSigned() async {
    final keepSigned = await _storage.read(key: 'keep_signed');
    return keepSigned == 'true';
  }
}