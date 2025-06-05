import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/ubicacion_reporte.dart';
import '../../domain/usecases/providers/obtener_reportes_usecase_provider.dart';

/// Provider que obtiene la lista de reportes desde el backend para mostrar en el mapa.
///
/// Ejecuta el caso de uso [ObtenerReportesMapaUseCase] para recuperar
/// reportes con ubicación y detalles relevantes. 
///
/// Se utiliza en la Vista 1 (pantalla principal del mapa).
final reportesMapaProvider = FutureProvider<List<UbicacionReporte>>((ref) async {
  final useCase = ref.read(obtenerReportesMapaUseCaseProvider);
  return await useCase();
});