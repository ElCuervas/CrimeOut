import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/estado_sistema.dart';
import '../../data/repositories/admin_repository_impl.dart';
import '../../data/datasources/admin_remote_data_source.dart';
import '../../domain/usecases/get_estado_sistema_usecase.dart';

final estadoSistemaProvider = FutureProvider<EstadoSistema>((ref) async {
  final usecase = GetEstadoSistemaUseCase(AdminRepositoryImpl(AdminRemoteDataSource()));
  return await usecase.execute();
});