import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/reporte_sospechoso_model.dart';

abstract class ReporteSospechosoRemoteDataSource {
  Future<List<ReporteSospechosoModel>> fetchReportesSospechosos();
}

class ReporteSospechosoRemoteDataSourceImpl implements ReporteSospechosoRemoteDataSource {
  final Dio dio;

  ReporteSospechosoRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ReporteSospechosoModel>> fetchReportesSospechosos() async {
    try {
      final response = await dio.get('/api/v1/crimeout/reportes/sospechoso');

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => ReporteSospechosoModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Error inesperado al obtener reportes sospechosos');
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error de red al obtener reportes');
    }
  }
}