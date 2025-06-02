import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../crear_reporte_usecase.dart';
import '../../../data/providers/reporte_repository_provider.dart';

final crearReporteUseCaseProvider = Provider<CrearReporteUseCase>((ref) {
  final repository = ref.read(reporteRepositoryProvider);
  return CrearReporteUseCase(repository);
});