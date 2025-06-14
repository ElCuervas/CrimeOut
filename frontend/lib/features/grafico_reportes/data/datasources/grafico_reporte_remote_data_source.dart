import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/grafico_reporte_model.dart';

class GraficoReporteRemoteDataSource {
  final Dio _dio = Dio();
  final _storage = const FlutterSecureStorage();
  final _baseUrl = 'http://10.0.2.2:8080/api/v1/crimeout';

  Future<GraficoReporteModel> fetchReportePorMes(String mes) async {
    final token = await _storage.read(key: 'jwt_token');

    final response = await _dio.get(
      '$_baseUrl/list/grafico/$mes',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return GraficoReporteModel.fromJson(response.data);
    } else {
      throw Exception('Error al obtener gráfico: ${response.statusMessage}');
    }
  }
}