import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/reporte_sospechoso_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ReporteSospechosoRemoteDataSource {
  Future<List<ReporteSospechosoModel>> fetchReportesSospechosos();
}

class ReporteSospechosoRemoteDataSourceImpl implements ReporteSospechosoRemoteDataSource {
  final dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8080'));
  final _storage = const FlutterSecureStorage();

  ReporteSospechosoRemoteDataSourceImpl();

  @override
  Future<List<ReporteSospechosoModel>> fetchReportesSospechosos() async {
    try {
      final token = await _storage.read(key: 'jwt_token');

      final response = await dio.get(
        '/api/v1/crimeout/reportes/sospechosos', 
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );

      dynamic data = response.data;

      // 🔍 Si el backend responde con String (posible con text/plain o encoding raro), decodificamos
      if (data is String) {
        data = jsonDecode(data);
      }

      // ✅ Si es lista, parseamos
      if (data is List) {
        return data.map((json) => ReporteSospechosoModel.fromJson(json)).toList();
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception('Error inesperado al obtener reportes sospechosos');
      }
    } on DioError catch (e) {
      print('📛 DioError al obtener reportes: ${e.response?.statusCode} | ${e.response?.data}');
      throw Exception(e.response?.data['message'] ?? 'Error de red al obtener reportes');
    } catch (e) {
      print('❌ Error general: $e');
      throw Exception('Error al procesar los datos de los reportes sospechosos');
    }
  }
}