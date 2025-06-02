import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/reporte_request.dart';
import '../../domain/usecases/providers/crear_reporte_usecase_provider.dart';
import '../../domain/usecases/providers/obtener_reportes_usecase_provider.dart';
import '../../domain/entities/ubicacion_reporte.dart';

/// Tipo de reporte seleccionado por el usuario (Vista 2)
final tipoReporteSeleccionadoProvider = StateProvider<String?>((ref) => null);

/// Ubicación seleccionada para el reporte (lat, lng) (Vista 3)
final ubicacionSeleccionadaProvider = StateProvider<List<double>?>((ref) => null);

/// Descripción textual del reporte (Vista 3 - Popup)
final detallesReporteProvider = StateProvider<String?>((ref) => '');

/// Imagen asociada al reporte (en base64 o URL) (Vista 3 - Popup)
final imagenReporteProvider = StateProvider<String?>((ref) => null);

/// Provider que llama al caso de uso para crear un nuevo reporte
final crearReporteProvider = FutureProvider<void>((ref) async {
  final tipo = ref.read(tipoReporteSeleccionadoProvider);
  final ubicacion = ref.read(ubicacionSeleccionadaProvider);
  final detalles = ref.read(detallesReporteProvider);
  final imagen = ref.read(imagenReporteProvider);
  const int userId = 1; // Temporal: reemplazar cuando login funcione

  if (tipo == null || ubicacion == null) {
    throw Exception('Faltan datos del reporte');
  }

  final reporte = ReporteRequest(
  idUsuario: userId,
  tipoReporte: tipo!,
  latitud: ubicacion[0],
  longitud: ubicacion[1],
  imagen: imagen ?? '',
  detalles: detalles ?? '',
  fecha: DateTime.now().toIso8601String(),
  confiable: false,
  solucionado: false,
);

  final useCase = ref.read(crearReporteUseCaseProvider);
  await useCase(reporte, userId);
});

/// Provider para obtener todos los reportes desde el backend (usado en Vista 1)
final reportesMapaProvider = FutureProvider<List<UbicacionReporte>>((ref) async {
  final useCase = ref.read(obtenerReportesMapaUseCaseProvider);
  return await useCase();
});