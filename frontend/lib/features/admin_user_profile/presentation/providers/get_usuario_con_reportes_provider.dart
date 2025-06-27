import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/usuario_con_reportes.dart';
import '../../data/repositories/usuario_con_reportes_repository_impl.dart';
import '../../domain/usecases/get_usuario_con_reportes_usecase.dart';


final usuarioConReportesProvider = FutureProvider.family<UsuarioConReportes, int>((ref, id) {
  final repository = UsuarioConReportesRepositoryImpl();
  final usecase = GetUsuarioConReportesUseCase(repository);
  return usecase.execute(id);
});

final eliminarUsuarioProvider = Provider<DeleteUsuarioUseCase>((ref) {
  final repository = UsuarioConReportesRepositoryImpl();
  return DeleteUsuarioUseCase(repository);
});