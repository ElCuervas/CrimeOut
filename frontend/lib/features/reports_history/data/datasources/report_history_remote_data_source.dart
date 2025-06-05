import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/report_history_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ReportHistoryRemoteDataSource {
  final storage = FlutterSecureStorage();
  final String baseUrl = 'http://10.0.2.2:8080/api/v1/crimeout';
  

  Future<ReporteUsuarioModel> getReportsByUserId(int userId) async {
    final token = await FlutterSecureStorage().read(key: 'jwt_token');
    final response = await http.get(
      Uri.parse('$baseUrl/user/$userId/reportes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("📥 Código de estado: ${response.statusCode}");
    print("📦 Respuesta JSON: ${response.body}");

    if (response.statusCode == 200) {
      return ReporteUsuarioModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar historial: ${response.body}');
    }
  }
}