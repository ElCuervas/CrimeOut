import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../domain/repositories/reporte_repository.dart';
import '../repositories/reporte_repository_impl.dart';

/// Proveedor de un cliente HTTP usando la librería `http`.
/// 
/// Este `Provider` entrega una instancia de `http.Client` para realizar solicitudes HTTP.
/// Se utiliza en conjunto con la implementación del repositorio que interactúa con la API.
final httpClientProvider = Provider((ref) => http.Client());

/// Proveedor de la URL base del backend, leída desde un archivo `.env`.
/// 
/// Este `Provider` accede a la variable de entorno `API_URL`, que debe estar definida
/// en un archivo `.env` usando la librería `flutter_dotenv`. Si la variable no está
/// presente o es vacía, lanza una excepción para evitar errores silenciosos.
final baseUrlProvider = Provider<String>((ref) {
  final url = dotenv.env['API_URL'];
  if (url == null || url.isEmpty) {
    throw Exception('API_URL no está definido en el archivo .env');
  }
  return url;
});

/// Proveedor del repositorio de reportes (`ReporteRepository`).
/// 
/// Combina el cliente HTTP y la URL base para instanciar `ReporteRepositoryImpl`,
/// que es la implementación concreta del repositorio que se comunica con la API.
/// Se usa en los casos de uso para enviar y obtener reportes.
final reporteRepositoryProvider = Provider<ReporteRepository>((ref) {
  final client = ref.read(httpClientProvider);
  final baseUrl = ref.read(baseUrlProvider);

  print('Usando baseUrl: $baseUrl'); // Ayuda a verificar que la URL se esté leyendo correctamente

  return ReporteRepositoryImpl(client: client, baseUrl: baseUrl);
});