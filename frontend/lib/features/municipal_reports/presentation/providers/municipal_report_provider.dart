import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/municipal_report.dart';
import '../../domain/usecases/get_reports_by_type_usecase.dart';
import '../../data/datasources/municipal_report_remote_data_source.dart';
import '../../data/repositories/municipal_report_repository_impl.dart';

import '../../domain/usecases/update_reporte_estado_usecase.dart';

/// Provider para obtener reportes por tipo para el rol MUNICIPAL
final municipalReportProvider =
    FutureProvider.family<List<ReporteMunicipal>, String>((ref, tipoReporte) async {
  final usecase = GetReportsByTypeUseCase(
    MunicipalReportRepositoryImpl(
      ReporteMunicipalRemoteDataSource(),
    ),
  );
  return await usecase.execute(tipoReporte);
});
final updateReporteEstadoUseCaseProvider = Provider<UpdateReporteEstadoUseCase>((ref) {
  return UpdateReporteEstadoUseCase(
    MunicipalReportRepositoryImpl(ReporteMunicipalRemoteDataSource()),
  );
});