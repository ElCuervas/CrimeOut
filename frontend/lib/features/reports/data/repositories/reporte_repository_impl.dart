import 'package:http/http.dart' as http;
import "package:frontend/features/reports/domain/entities/reporte_request.dart";
import "package:frontend/features/reports/domain/repositories/reporte_repository.dart";
import "package:frontend/features/reports/domain/entities/ubicacion_reporte.dart";
import 'dart:convert';

/// Implementación concreta de [ReporteRepository] que se comunica con la API REST.
///
/// Utiliza un cliente HTTP y una URL base para realizar solicitudes
/// a los endpoints relacionados con los reportes.
class ReporteRepositoryImpl implements ReporteRepository {
  /// Cliente HTTP utilizado para enviar solicitudes.
  final http.Client client;

  /// URL base del backend (por ejemplo, `http://localhost:8080/api/v1/crimeout`)
  final String baseUrl;

  /// Constructor que requiere un [http.Client] y la [baseUrl] para inicializar.
  ReporteRepositoryImpl({required this.client, required this.baseUrl});

  /// Envía un nuevo reporte al backend.
  ///
  /// Realiza un `POST` al endpoint `/user/{id}/reporte` con los datos del [request]
  /// serializados a JSON. Si la respuesta no tiene código 200, lanza una excepción.
  ///
  /// - Parámetros:
  ///   - [request]: Objeto que contiene el tipo de reporte, ubicación, detalles e imagen.
  ///   - [userId]: Identificador del usuario que realiza el reporte.
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

  /// Obtiene una lista de reportes con sus ubicaciones desde el backend.
  ///
  /// Realiza un `GET` al endpoint `/reportes`. Si el código de estado es 200,
  /// decodifica la respuesta y transforma cada elemento en un objeto [UbicacionReporte].
  ///
  /// - Retorna: Una lista de ubicaciones de reportes en forma de [UbicacionReporte].
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