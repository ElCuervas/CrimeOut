import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/reporte_sospechoso_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ReporteSospechosoRemoteDataSource {
  Future<List<ReporteSospechosoModel>> fetchReportesSospechosos();
}

class ReporteSospechosoRemoteDataSourceImpl implements ReporteSospechosoRemoteDataSource {
  final Dio dio;
  final _storage = const FlutterSecureStorage();

  ReporteSospechosoRemoteDataSourceImpl(this.dio);

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

    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((json) => ReporteSospechosoModel.fromJson(json))
          .toList();
    } else if (response.statusCode == 204) {
      // Sin contenido = lista vacía
      return [];
    } else {
      throw Exception('Error inesperado al obtener reportes sospechosos');
    }
  } on DioError catch (e) {
    print('📛 DioError al obtener reportes: ${e.response?.statusCode} | ${e.response?.data}');
    throw Exception(e.response?.data['message'] ?? 'Error de red al obtener reportes');
  }
}
}