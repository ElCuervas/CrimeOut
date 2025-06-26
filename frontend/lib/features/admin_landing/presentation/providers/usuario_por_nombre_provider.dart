import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/usuario_admin.dart';
import '../../data/repositories/admin_repository_impl.dart';
import '../../data/datasources/admin_remote_data_source.dart';
import '../../domain/usecases/get_usuario_por_nombre_usecase.dart';

final usuarioPorNombreProvider = FutureProvider.family<UsuarioAdmin, String>((ref, nombre) async {
  final usecase = GetUsuarioPorNombreUseCase(AdminRepositoryImpl(AdminRemoteDataSource()));
  return await usecase.execute(nombre);
});