import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../domain/repositories/reporte_repository.dart';
import '../repositories/reporte_repository_impl.dart';

final httpClientProvider = Provider((ref) => http.Client());

/// Lee la URL base desde el archivo `.env`
final baseUrlProvider = Provider<String>((ref) {
  final url = dotenv.env['API_URL'];
  if (url == null || url.isEmpty) {
    throw Exception('API_URL no está definido en el archivo .env');
  }
  return url;
});

final reporteRepositoryProvider = Provider<ReporteRepository>((ref) {
  final client = ref.read(httpClientProvider);
  final baseUrl = ref.read(baseUrlProvider);

  print('Usando baseUrl: $baseUrl'); // Solo para confirmar en consola

  return ReporteRepositoryImpl(client: client, baseUrl: baseUrl);
});