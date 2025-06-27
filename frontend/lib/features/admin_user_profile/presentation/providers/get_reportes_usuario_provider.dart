import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/repositories/usuario_reportes_repository_impl.dart';
import '../../domain/usecases/get_reportes_de_usuario_usecase.dart';
import '../../domain/entities/reporte_usuario.dart';

// Provider para el use case
final getReportesDeUsuarioUseCaseProvider = Provider<GetReportesDeUsuarioUseCase>((ref) {
  final repository = UsuarioReportesRepositoryImpl(Dio());
  return GetReportesDeUsuarioUseCase(repository);
});