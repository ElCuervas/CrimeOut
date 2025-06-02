import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../obtener_reportes_mapa_usecase.dart';
import '../../../data/providers/reporte_repository_provider.dart';

/// Provider que expone una instancia de [ObtenerReportesMapaUseCase].
///
/// Este provider se encarga de construir el caso de uso que obtiene los reportes
/// georreferenciados desde el backend. Utiliza el [reporteRepositoryProvider] como
/// fuente de datos.
///
/// Uso:
/// ```dart
/// final useCase = ref.read(obtenerReportesMapaUseCaseProvider);
/// ```
final obtenerReportesMapaUseCaseProvider = Provider<ObtenerReportesMapaUseCase>((ref) {
  final repository = ref.read(reporteRepositoryProvider);
  return ObtenerReportesMapaUseCase(repository);
});