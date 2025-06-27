import 'package:dio/dio.dart';
import '../models/municipal_report_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReporteMunicipalRemoteDataSource {
  final Dio _dio = Dio();
  final _storage = const FlutterSecureStorage();
  final _baseUrl = 'http://10.0.2.2:8080/api/v1/crimeout';

  Future<List<ReporteMunicipalModel>> fetchReportesPorTipo(String tipo) async {
    final token = await _storage.read(key: 'jwt_token');
    final response = await _dio.get(
      '$_baseUrl/list/municipal/$tipo/reportes',
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }),
    );

    if (response.statusCode == 200) {
      final List datos = response.data;
      return datos.map((r) => ReporteMunicipalModel.fromJson(r)).toList();
    } else {
      throw Exception('Error al cargar reportes');
    }
  }

  /// 🔁 PATCH para actualizar estado del reporte
  Future<void> actualizarEstadoReporte({
  required int id,
  required bool confiable,
  required bool solucionado,
}) async {
  final token = await _storage.read(key: 'jwt_token');

  try {
    final response = await _dio.patch(
      '$_baseUrl/reporte/$id',
      data: {
        'confiable': confiable,
        'solucionado': solucionado,
      },
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json', // 🔹 Importante si el backend necesita esto
      }),
    );

    print("📦 Respuesta bruta: ${response.data}");

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar reporte');
    }
  } on DioException catch (e) {
    print('🚨 DioException: ${e.response?.data}');
    rethrow;
  } catch (e) {
    print('🚨 Error desconocido: $e');
    rethrow;
  }
}
}

