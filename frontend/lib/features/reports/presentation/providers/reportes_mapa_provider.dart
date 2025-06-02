import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/ubicacion_reporte.dart';
import '../../domain/usecases/providers/obtener_reportes_usecase_provider.dart';

final reportesMapaProvider = FutureProvider<List<UbicacionReporte>>((ref) async {
  final useCase = ref.read(obtenerReportesMapaUseCaseProvider);
  return useCase();
});