import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/reporte_request.dart';
import '../../domain/usecases/providers/crear_reporte_usecase_provider.dart';
import '../providers/reporte_providers.dart';
import 'package:frontend/screens/providers/userIdProvider.dart';

/// Provider encargado de enviar un nuevo reporte al backend.
///
/// Este [FutureProvider] recoge los datos desde los providers de estado
/// [tipoReporteSeleccionadoProvider], [ubicacionSeleccionadaProvider],
/// [detallesReporteProvider] e [imagenReporteProvider], construye un
/// [ReporteRequest] y ejecuta el caso de uso [CrearReporteUseCase].
final crearReporteProvider = FutureProvider<void>((ref) async {
  final tipo = ref.read(tipoReporteSeleccionadoProvider);
  final ubicacion = ref.read(ubicacionSeleccionadaProvider);
  final detalles = ref.read(detallesReporteProvider);
  final imagen = ref.read(imagenReporteProvider);

  final userId = await ref.read(userIdProvider.future);

  if (tipo == null || ubicacion == null) {
    throw Exception('Faltan datos del reporte');
  }

  // Construcción del objeto ReporteRequest con formato esperado por el backend
  final reporte = ReporteRequest(
    idUsuario: userId,
    tipoReporte: tipo,
    latitud: ubicacion[0],
    longitud: ubicacion[1],
    imagen: imagen ?? '',
    detalles: detalles ?? '',
    fecha: DateTime.now().toIso8601String(),
    confiable: false,
    solucionado: false,
  );

  // Ejecutar caso de uso para enviar el reporte
  final useCase = ref.read(crearReporteUseCaseProvider);
  await useCase(reporte, userId);
});