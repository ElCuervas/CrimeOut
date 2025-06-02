import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../crear_reporte_usecase.dart';
import '../../../data/providers/reporte_repository_provider.dart';

/// Provider que expone una instancia de [CrearReporteUseCase].
///
/// Este provider obtiene una instancia de [ReporteRepository] a través
/// de [reporteRepositoryProvider] y la utiliza para construir el caso de uso
/// encargado de crear reportes.
///
/// Uso:
/// ```dart
/// final useCase = ref.read(crearReporteUseCaseProvider);
/// ```
final crearReporteUseCaseProvider = Provider<CrearReporteUseCase>((ref) {
  final repository = ref.read(reporteRepositoryProvider);
  return CrearReporteUseCase(repository);
});