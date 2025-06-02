import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../obtener_reportes_mapa_usecase.dart';
import '../../../data/providers/reporte_repository_provider.dart';

final obtenerReportesMapaUseCaseProvider = Provider<ObtenerReportesMapaUseCase>((ref) {
  final repository = ref.read(reporteRepositoryProvider);
  return ObtenerReportesMapaUseCase(repository);
});