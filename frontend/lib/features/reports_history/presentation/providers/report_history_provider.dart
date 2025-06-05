import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/report_history_remote_data_source.dart';
import '../../data/repositories/report_history_repository_impl.dart';
import '../../domain/usecases/get_user_reports_usecase.dart';
import '../../domain/entities/report_history.dart';
import 'package:frontend/core/utils/jwt_utils.dart';
import 'package:frontend/features/auth/presentation/providers/userIdProvider.dart';

final reportHistoryProvider = FutureProvider<ReporteUsuario>((ref) async {
  try {
    final id = await ref.watch(userIdProvider.future);
    final usecase = GetUserReportsUseCase(
      ReportHistoryRepositoryImpl(ReportHistoryRemoteDataSource()),
    );
    final result = await usecase.execute(id);
    print("✅ Reportes cargados correctamente para usuario $id");
    return result;
  } catch (e, stack) {
    print("🔥 ERROR al obtener historial de reportes: $e");
    print("📌 StackTrace: $stack");
    throw Exception('No se pudo cargar el historial de reportes.');
  }
});