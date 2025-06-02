import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/reporte_request.dart';
import '../../domain/usecases/providers/crear_reporte_usecase_provider.dart';
import '../providers/reporte_providers.dart';


final crearReporteProvider = FutureProvider<void>((ref) async {
  final tipo = ref.read(tipoReporteSeleccionadoProvider);
  final ubicacion = ref.read(ubicacionSeleccionadaProvider);
  final detalles = ref.read(detallesReporteProvider);
  final imagen = ref.read(imagenReporteProvider);

  const int userId = 1; // Reemplazar cuando tengas login

  if (tipo == null || ubicacion == null) {
    throw Exception('Faltan datos del reporte');
  }

  final reporte = ReporteRequest(
    idUsuario: userId,
    tipoReporte: tipo[0] + tipo.substring(1).toLowerCase(), // Ej: "BASURAL" → "Basural"
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