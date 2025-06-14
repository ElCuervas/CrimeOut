import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/grafico_reporte.dart';
import '../../domain/usecases/get_grafico_reporte_usecase.dart';
import '../../data/datasources/grafico_reporte_remote_data_source.dart';
import '../../data/repositories/grafico_reporte_repository_impl.dart';

/// 📦 Provider para obtener los datos del gráfico según el mes (ej. '03-2025')
final graficoProvider = FutureProvider.family<GraficoReporte, String>((ref, mes) async {
  final usecase = GetGraficoReporteUseCase(
    GraficoReporteRepositoryImpl(
      GraficoReporteRemoteDataSource(),
    ),
  );
  return await usecase.execute(mes);
});