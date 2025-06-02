import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/reporte_request.dart';
import '../../domain/usecases/providers/crear_reporte_usecase_provider.dart';
import '../../domain/usecases/providers/obtener_reportes_usecase_provider.dart';
import '../../domain/entities/ubicacion_reporte.dart';
import 'package:frontend/screens/providers/userIdProvider.dart';

/// Provider que almacena el tipo de reporte seleccionado por el usuario.
///
/// Se actualiza desde la Vista selección de tipo de reporte.
final tipoReporteSeleccionadoProvider = StateProvider<String?>((ref) => null);

/// Provider que almacena la ubicación seleccionada para el reporte.
///
/// Representado como una lista [latitud, longitud]. Se establece en la Vista Seleccionar Ubicacion.
final ubicacionSeleccionadaProvider = StateProvider<List<double>?>((ref) => null);

/// Provider que contiene los detalles escritos por el usuario sobre el reporte.
///
/// Se actualiza desde el popup de detalles en la Vista Seleccionar Ubicacion.
final detallesReporteProvider = StateProvider<String?>((ref) => '');

/// Provider que almacena la imagen del reporte en formato base64 o URL.
///
/// La imagen es opcional y se selecciona en el popup de la Vista Seleccionar Ubicacion.
final imagenReporteProvider = StateProvider<String?>((ref) => null);

/// Provider que se encarga de crear un nuevo reporte.
///
/// Utiliza los datos recolectados por los providers de estado anteriores.
/// Ejecuta el caso de uso [CrearReporteUseCase].
///
/// Lanza una excepción si faltan datos requeridos.
final crearReporteProvider = FutureProvider<void>((ref) async {
  final tipo = ref.read(tipoReporteSeleccionadoProvider);
  final ubicacion = ref.read(ubicacionSeleccionadaProvider);
  final detalles = ref.read(detallesReporteProvider);
  final imagen = ref.read(imagenReporteProvider);

  final userId = await ref.read(userIdProvider.future) as int;

  if (tipo == null || ubicacion == null) {
    throw Exception('Faltan datos del reporte');
  }

  final reporte = ReporteRequest(
    tipoReporte: tipo,
    latitud: ubicacion[0],
    longitud: ubicacion[1],
    imagen: imagen ?? '',
    detalles: detalles ?? ''
  );

  final useCase = ref.read(crearReporteUseCaseProvider);
  await useCase(reporte, userId);
});

/// Provider que obtiene todos los reportes para ser mostrados en el mapa.
///
/// Este provider ejecuta el caso de uso [ObtenerReportesMapaUseCase].
/// Es utilizado en la Vista 1 (mapa de reportes).
final reportesMapaProvider = FutureProvider<List<UbicacionReporte>>((ref) async {
  final useCase = ref.read(obtenerReportesMapaUseCaseProvider);
  return await useCase();
});