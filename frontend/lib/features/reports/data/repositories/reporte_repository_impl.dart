import 'package:http/http.dart' as http;
import "package:frontend/features/reports/domain/entities/reporte_request.dart";
import "package:frontend/features/reports/domain/repositories/reporte_repository.dart";
import "package:frontend/features/reports/domain/entities/ubicacion_reporte.dart";
import 'dart:convert';


class ReporteRepositoryImpl implements ReporteRepository {
  final http.Client client;
  final String baseUrl;

  ReporteRepositoryImpl({required this.client, required this.baseUrl});

  @override
  Future<void> crearReporte(ReporteRequest request, int userId) async {
    final response = await client.post(
      Uri.parse('$baseUrl/api/v1/crimeout/user/$userId/reporte'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al enviar el reporte');
    }
  }

  @override
  Future<List<UbicacionReporte>> obtenerReportesMapa() async {
    final response = await client.get(
      Uri.parse('$baseUrl/api/v1/crimeout/reportes'),
    );

    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      return decoded.map((r) => UbicacionReporte.fromJson(r)).toList();
    } else {
      throw Exception('Error al obtener reportes');
    }
  }
}