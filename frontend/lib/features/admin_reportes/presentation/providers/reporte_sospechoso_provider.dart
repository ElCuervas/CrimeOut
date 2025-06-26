import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:frontend/features/admin_reportes/data/datasources/reporte_sospechoso_remote_data_source.dart';
import 'package:frontend/features/admin_reportes/data/repositories/reporte_sospechoso_repository_impl.dart';
import 'package:frontend/features/admin_reportes/domain/entities/reporte_sospechoso.dart';
import 'package:frontend/features/admin_reportes/domain/usecases/get_reportes_sospechosos_usecase.dart';

final reporteSospechosoProvider = FutureProvider<List<ReporteSospechoso>>((ref) async {
  final dio = Dio(); 
  final dataSource = ReporteSospechosoRemoteDataSourceImpl(dio);
  final repository = ReporteSospechosoRepositoryImpl(dataSource);
  final usecase = GetReportesSospechososUseCase(repository);

  return await usecase.execute();
});